## Desenvolvimento vs Produção

Até o momento, temos utilizado o Elasticsearch em modo de _desenvolvimento_. Este modo é assumido por padrão pela ferramenta, caso você não modifique o parâmetro `network.host` no arquivo principal _/config/elasticsearch.yml_. Ao configurarmos um endereço de IP para a nossa instância, o Elasticsearch passa a __exigir__ que algumas configurações adicionais sejam feitas no host em que o mesmo reside para o seu funcionamento, caso contrário será impossível até mesmo de iniciar a sua instância.

Em um cenário ideal, o Elasticsearch deve ser executado sem nenhuma outra aplicação concorrente, em um servidor dedicado ao seu uso e deve ter acesso a todos os recursos computacionais disponíveis. Para isso, precisamos realizar algumas configurações no nosso sistema operacional para permitir que ele tenha mais acesso à estes recursos do que é disponibilizado por default.

Pode ser que você desconheça alguns dos parâmetros de sistema operacional que iremos alterar abaixo. Como o objetivo deste repositório é ser o mais objetivo possível no aprendizado do Elastic Stack, tente não se prender muito a isto, para podermos focar no que realmente precisamos aprender sobre a nossa stack, ok :) ?

Antes de mais nada, finalize todas as suas instâncias de Elasticsearch, Logstash e Kibana executando um `kill` em seus respectivos processos em execução.

#### Memória Virtual e "Swapping"

"Swapping" ("swappar", "fazer um swap", "dar aquela swappada", etc), faz com que a performance da sua instância caia bastante, sendo assim é recomendado que a área de swap seja desabilitado por completo com o comando `sudo swapoff -a`. Caso isso não seja possível, alterar o valor do _swapiness_ para 1 já é o suficiente. Vamos seguir com a segunda opção para o nosso ambiente. Vamos também alterar o espaço utilizado para o mapeamento de memória. Lembre-se de executar todos os comandos abaixo como __root__:

```
# sysctl -w vm.swappiness=1
# sysctl -w vm.max_map_count=262144
```

#### Aumentar a quantidade de "file descriptors"

O Elasticsearch pode vir a utilizar uma grande quantidade de "file descriptors" e manter uma quantidade baixa disponível pode acarretar em uma real perda de dados. Edite o arquivo /etc/security/limits.conf com as seguintes diretivas para configurarmos um valor aceitável:

```
elasticsearch soft nofile 65536
elasticsearch hard nofile 65536
```

__OBS:__ "elasticsearch" é o usuário utilizado para a subida da instância. Caso esteja utilizando um usuário diferente, apenas troque e seja feliz.

As configurações de memória e file descriptors podem já ser o suficiente para a subida com sucesso da sua instância de Elasticsearch em modo de produção. Vamos apresentar mais uma parametrização indicada pela [documentação](https://www.elastic.co/guide/en/elasticsearch/reference/current/system-config.html#dev-vs-prod) da Elastic, apenas para conhecimento.

#### Garantir Threads suficientes

Precisamos garantir que o número de threads criadas pelo Elasticsearch seja de pelo menos 4096. Configuramos isto com o comando abaixo:

```
ulimit -u 4096
```

#### Network host

Agora a nossa instância está pronta para ser utilizada em  o modo de produção. Edite o arquivo /config/elasticsearch.yml e altere o valor conforme abaixo:

```
network.host: <IP_DO_SEU_HOST>
```
__OBS:__ Caso esteja com vontade de nomear a sua instância, altere o parâmetro `node.name:` e adicione um nome de sua preferência.

Como declaramos que a nossa instância de Elasticsearch utilizará um endereço fixo no nosso host, precisamos também alterar os arquivos de configuração do Kibana e do Logstash:

```
vim kibana-5.6.5/config/kibana.yml:
elasticsearch.url: "http://<IP_DO_SEU_HOST>:9200"
```

```
vim logstash-5.6.5/config/logstash-apache.conf
hosts => ["<IP_DO_SEU_HOST>:9200"]
```

Feito isso, inicie sua instância de Elasticsearch e acompanhe a saída do arquivo _nohup.out_ para ver se nenhuma mensagem de erro será exibida. Após a subida com sucesso da sua instância, a mesma agora poderá ser acessada através do IP configurado anteriormente:

```
curl -XGET http://<IP_DO_SEU_HOST>:9200
{
  "name" : "EuubzCb",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "bG-qQOdXSL-McKietkxktQ",
  "version" : {
    "number" : "5.6.5",
    "build_hash" : "6a37571",
    "build_date" : "2017-12-04T07:50:10.466Z",
    "build_snapshot" : false,
    "lucene_version" : "6.6.1"
  },
  "tagline" : "You Know, for Search"
}
```

Legal, agora temos uma instância produtiva em total funcionamento. Estes passos são essenciais para uma configuração onde o seu node de Elasticsearch precisa ser acessado por algum host remoto e é exatamente sobre isso que iremos falar agora...

Próximo: [Beats](/pages/beats.md)
