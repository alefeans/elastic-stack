##### Shards e Replicas

Quando indexamos nossos documentos no Elasticsearch (lembre-se do significado de _indexar_ explicado anteriormente), estamos adicionando nossos dados em um __shard__, que são basicamente containers que armazenam os dados que indexamos no Elasticsearch. Porém nossas aplicações não falam diretamente com o shard em si, mas sim com os índices (lembre-se das inserções que fizemos anteriormente). A realidade é que os índices, mycompany ou twitter por exemplo, são apenas _namespaces lógicos_ que apontam para um ou mais __shards__. Ou seja, quando realizamos uma inserção de um documento em um index no Elasticsearch, passamos o caminho do index que queremos utilizar, e este, irá armazenar este documento em algum shard qualquer (como se fosse um balanceador que redireciona o tráfego de rede para um grupo de servidores).

Após o direcionamento para um shard, o Apache Lucene entra em ação. Dentro de cada shard, há uma instância de Lucene em execução, utilizando o seu motor de busca e indexação para acessar/armazenar os nossos dados. Isso nos garante toda a inteligência e velocidade que esta biblioteca possui na busca de documentos.

Vamos executar um comando que utilizamos no inicio deste repositório para validarmos a quantidade de índices criados e consultarmos algumas informações sobre os nossos shards:

```
curl -XGET http://localhost:9200/_cat/indices?v
```

Provavelmente você recebeu um retorno parecido com este (formatei em tabela para melhorar a visualização):

| health| status | index | uuid | pri | rep | docs.count| docs.deleted| store.size| pri.store.size|
| ----- |--------|----- |------|----- |--------|----- |--------|----|:------:|
|yellow | open | mycompany | pUEvAXsjQIm | 5 | 1 | 3 | 0| 17.8kb | 17.8kb |
|yellow | open | twitter | LKz87NMtTlShp | 5 | 1 | 14 | 0| 29.9kb | 29.9kb |

Quando iniciamos uma instância de Elasticsearch, por default são criados 5 shards (coluna __pri__, que significa "primary"), com 1 réplica por shard (coluna __rep__, que significa "replica"). A medida que adicionamos mais instâncias em nosso cluster, os shards são replicados/migrados entre os nodes pelo próprio Elasticsearch, que fará o possível para manter o nosso cluster balanceado. Um shard _primary_ possui a função de armazenar todos os documentos do seu index. Já um shard _replica_, garante a redundância dos seus dados, servindo como uma cópia do seu shard primary e também, respondendo à requisições de leitura/busca de documentos.

Avaliando a tabela com o resultado do nosso comando, vemos que o "health" do nosso cluster está em "yellow", certo ? Isso se deve ao fato de possuirmos cinco shards primários armazenando nossos dados em um mesmo node, e a perda de um deles, seja por uma falha de hardware por exemplo, pode resultar em uma perda real de dados. Veja a imagem abaixo para entender melhor em que cenário o nosso cluster se encontra:

![](images/five_shards.png)

__Legenda__: P = Primary.

__OBS:__ Na realidade, nosso cluster possui 10 shards primários, já que possuímos 2 index diferentes (mycompany e twitter). Na imagem acima, considere que estamos visualizando apenas os shards de um único index, que pode ser qualquer um dos dois que possuímos em nosso ambiente.

Mas aonde estão as nossas réplicas ? Execute o comando utilizado para verificar a saúde do cluster novamente (.../_cluster/health?pretty) e observe o retorno do comando. Veja que há um campo chamado, __"unassigned_shards"__ com o valor 10. Isso significa que possuímos 10 shards que não estão associados a nenhum node de Elasticsearch e esses shards, são exatamente as nossas réplicas. Lembre-se, por default o Elasticsearch cria 5 shards primários e 1 réplica por shard quando criamos um index. O número de réplicas sempre estará associado ao número de shards primários, ou seja, possuímos 1 réplica para cada shard (5 * 1 = 5), e como possuímos dois index, dobramos este valor (5 * 2 = 10).

__OBS:__ Caso seja necessário, validem os resultados acima utilizando uma calculadora apropriada.

Pense na estratégia adotada pelo Elasticsearch em não associar nenhuma réplica ao nosso _single node_. Faz todo o sentido ! Não há nenhuma vantagem em armazenar as cópias dos mesmos dados em um mesmo node, pois caso venhamos a perder este node, tanto a cópia quanto a "original" seriam comprometidas. Sendo assim, o status do nosso cluster é classificado como "yellow" e permanecerá assim, até adicionarmos novos nodes em nosso cluster e termos nossas réplicas balanceadas entre eles.

Para termos uma melhor visualização nos próximos passos, vamos deletar os nossos índices "mycompany" e "twitter". Sim eu sei que é doloroso, _but we have to do it_:

```
curl -XDELETE http://localhost:9200/mycompany,twitter
```
__OBS:__ Veja que podemos apagar mais de um index em um só comando, separando-os por vírgula ! _Wildcards_ também são aceitos como parâmetro (Ex: *, ?, e etc), porém não são recomendados devido a grande capacidade que temos de fazer merda ao utilizá-los.

O número de shards primários é fixado no momento da criação do index, enquanto a quantida de réplicas pode ser alterada a qualquer momento. Vamos criar um novo index chamado "market" e alterar a quantidade de shards primários que serão criados pelo Elasticsearch:

```
curl -XPUT http://localhost:9200/market -d '
{
"settings" : {
    "index" : {
        "number_of_shards" : 3,
        "number_of_replicas" : 1
    }
}
}'
```

Legal, se chamarmos novamente a API _cluster para verificarmos a saúde novamente, estaremos vendo algo parecido com isso:

```
{
"cluster_name" : "elasticsearch",
"status" : "yellow",
"timed_out" : false,
"number_of_nodes" : 1,
"number_of_data_nodes" : 1,
"active_primary_shards" : 3,
"active_shards" : 3,
"relocating_shards" : 0,
"initializing_shards" : 0,
"unassigned_shards" : 3,
"delayed_unassigned_shards" : 0,
"number_of_pending_tasks" : 0,
"number_of_in_flight_fetch" : 0,
"task_max_waiting_in_queue_millis" : 0,
"active_shards_percent_as_number" : 50.0
}
```

Temos agora, 3 shards primários ativos e 3 shards desassociados, como esperávamos,  certo ? Vamos adicionar mais um node de Elasticsearch em nosso cluster para resolvermos essa questão de "alta disponibilidade" (leia com a voz que você faz quando está debochando de alguém). Sem precisar alterar nada, vá até o diretório "bin/" da instalação do seu Elasticsearch e execute o comando de subida da instância, conforme abaixo:

```
nohup ./elasticsearch -Epath.data=data2 -Epath.logs=log2 &
```
__OBS:__ Não se esqueça de validar o quanto de memória disponível você possui no seu servidor, pois iremos subir uma nova instância de Elasticsearch que irá consumir em média 2gb~2,5gb de memória. Também não se preocupe se não possuir esta quantidade disponível, pois isso não impedirá a realização dos passos subsequentes do nosso treinamento :).

O comando acima simplesmente inicia uma nova instância de Elasticsearch informando  um caminho diferente para o armazenamento dos dados (_-Epath.data=data2_) e um outro diretório para o armazenamento de logs (_-Epath.logs=log2_). Veja que agora os dois novos diretórios foram criados no diretório que o comando foi executado:

```
$ ls -ltr | grep ^d
drwxrwxr-x. 2 alefeans alefeans   4096 jan 11 16:20 log2
drwxrwxr-x. 3 alefeans alefeans   4096 jan 11 16:20 data2
```
Caso queira alterar para um outro caminho de sua preferência, sinta-se a vontade e passe o caminho completo do diretório como parâmetro. Vamos verificar o status do nosso cluster agora ? Chama aquela API que mostra o status do seu cluster você já está cansado de usar e veja se o resultado está parecido com este:

```
{
"cluster_name" : "elasticsearch",
"status" : "green",
"timed_out" : false,
"number_of_nodes" : 2,
"number_of_data_nodes" : 2,
"active_primary_shards" : 3,
"active_shards" : 6,
"relocating_shards" : 0,
"initializing_shards" : 0,
"unassigned_shards" : 0,
"delayed_unassigned_shards" : 0,
"number_of_pending_tasks" : 0,
"number_of_in_flight_fetch" : 0,
"task_max_waiting_in_queue_millis" : 0,
"active_shards_percent_as_number" : 100.0
}
```

Olha que legal, agora o nosso cluster status está como "green", possuimos um "number_of_nodes" de 2, temos 6 "active_shards" e nenhum "unassigned_shards". Apesar de estarmos utilizando o mesmo hardware (o que não garante nenhuma alta disponibilidade real), por possuirmos 2 nodes em nosso cluster, o Elasticsearch já o considera como "green" por conta da distribuilão dos shards primários e réplicas.

Mas vamos lá ... como esta nova instância _simplesmente_ começou a fazer parte do meu cluster ? E como minhas replicas e shards foram distribuidas pelo Elasticsearch ?

Pois bem, o Elasticsearch em sua configuração padrão, já vem com o cluster_name __"elasticsearch"__ e ao ser iniciado, realiza a busca por outro node master em sua máquina local. Ao subirmos esta outra instância com a mesma configuração, ele procurou por estas informações em sua máquina local e pronto, começou a fazer parte do nosso cluster.

Se quisessemos configurar um node de Elasticsearch em uma máquina remota para fazer parte do nosso cluster, teríamos que configurar alguns parâmetros a mais (endereço do servidor remoto, node name e etc), em seu arquivo de configuração principal: **config/elasticsearch.yml**. Mas isto não vem ao caso agora. Quer saber como os seus shards estão balanceados entre os seus nodes agora ? Veja a imagem abaixo:

![](images/two_nodes.png)

__Legenda:__ P = Primary; R = Replica.

Agora possuímos todas as nossas réplicas associadas ao nosso node 2. Perceba que qualquer requisição pode ser atendida por qualquer node, já que possuímos exatamente __todos__ os dados replicados em todos os nodes de nosso cluster. Para uma última ilustração, caso tivessemos 3 nodes e 2 réplicas, nosso cluster estaria representado mais ou menos desta forma:

![](images/three_nodes.png)


Caso haja uma falha em qualquer um dos nodes, temos a garantia de que qualquer outro node restante será capaz de responder a qualquer tipo de requisição de inserção/leitura de documentos.

Existem diversas configurações que podem ser feitas e melhoradas em um ambiente produtivo real à respeito de cluster, shards e replicas, mas este não é o foco deste repositório. Mais informações à respeito de configurações, redundância e performance, são encontradas facilmente na documentação oficial da Elastic.
