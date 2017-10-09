# Elastic Stack para iniciantes
   
   O objetivo desse repositório é apresentar o `Elastic Stack` de uma forma simples e amigável para quem está iniciando no assunto.
   
   Quando comecei a estudar sobre o Elastic Stack, encontrei diversos conteúdos que traziam explicações muito "pesadas" e que em alguns segundos de leitura, te levavam a realizar várias pesquisas para entender o significado de cada sub-tópico, conceito ou ferramenta adjacente.
   
   
   Sendo assim, decidi criar este repositório com uma linguagem mais informal e direta para explicar a _stack_, sem deixar de apresentar os conceitos essenciais. Não se preocupe se em alguns momentos aparecerem termos confusos que ainda não foram explicados, pois ao longo do treinamento eles se tornarão claros para você :)
   
   Inicialmente, vamos conceituar o que cada ferramenta é e o seu propósito.

## Elasticsearch


  O `elasticsearch` é uma ferramenta de buscas _open source_ desenvolvido em Java, assim como é uma solução NoSQL, ou seja, não segue os padrões de bancos de dados SQL comuns (como o MySQL, por exemplo). Ele tem como base o [Apache Lucene](https://github.com/apache/lucene-solr), que é uma biblioteca Java de pesquisa _full text_ e que é também, o motor de busca open source mais avançado oferecido hoje em dia. Porém, usar todo o poder de fogo do Lucene exige um certo esforço. Afinal, por ser uma biblioteca, você precisa trabalhar com o Java para integrá-lo com sua aplicação, algo que pode ser um pouco complexo.
  
  O Elasticsearch no entanto, se aproveita do Lucene na _indexação_ e pesquisa de documentos, retirando a sua complexidade através de uma API RESTful super fácil de se utilizar. Além disso, vamos citar algumas características que o tornam uma ferramenta excelente e extremamente veloz:
  
* Uma API RESTful para inclusão, remoção e acesso aos dados utilizando o padrão JSON.
* Totalmente livre de normalização.
* Qualquer palavra _indexada_ no elasticsearch pode ser pesquisada da mesma forma como você faz uma busca no Google.
* Altamente escalável (feito para o _Cloud Computing_).
* Permite pesquisas estruturadas e analíticas em _real-time_.
* Possui uma inteligência interna que entrega o melhor resultado em relação a busca feita (análise de relevância).
* Extremamente rápido. Explicaremos o por quê `:)` 

## Onde usar ?

  Tudo bem, ficou claro o que o Elasticsearch é. Mas aonde e como eu posso utilizá-lo ? 
  
__Exemplo 1:__
Bem, um dos cenários mais comuns é utiliza-lo como um agregador de logs em conjunto com o Logstash e o Kibana, que são outras ferramentas da organização _Elastic_, formando o que chamamos atualmente de `Elastic Stack` (o acrônimo `ELK` não é mais utilizado). Através desta _stack_ de ferramentas, possuímos uma ferramenta de busca e armazenamento de documentos (Elasticsearch), uma ferramenta de agregação, filtro e envio de dados (Logstash) e por fim, uma _web view_ para pesquisa e análise gráfica dos dados já armazenados (o nosso querido Kibana).

A partir disso, você sysadmin ou desenvolvedor, pode centralizar qualquer tipo de log gerado por _"qualquer coisa que gere log"_ e então, realizar análises, pesquisas de baseline ou montar dashboards de métricas pré-definidas. 

Vamos imaginar a seguinte situação: você é responsável por um sistema computacional, que possui 30 servidores e em cada um, 30 _microserviços_ diferentes. De repente, algum problema crítico acontece com este sistema e você precisa descobrir o que ocorreu. Por instinto, você irá ler as logs do sistema para tentar entender o que houve, certo ? Mas... será que você pode se dar ao luxo de logar em 30 servidores e procurar a log entre 30 microserviços diferentes em um momento de crise ? 

Agora, se você possuir um ponto central que lhe permita realizar uma busca através de uma sintaxe super simples ou ainda que lhe permita gerar um gráfico que contabilize a quantidade de vezes que esse erro ocorre, será muito mais fácil de identificar o problema não concorda ? Prazer, `Elastic Stack`.

__Exemplo 2:__
Outra forma de se usar o Elasticsearch é como uma solução NoSQL. Como ele escala horizontalmente com extrema facilidade (escalar horizontalmente nada mais é do que adicionar novos servidores com instâncias de Elasticsearch, atuando como se fosse uma (_cluster_)), é comum ver empresas utilizando-o como um _Big Data_, já que a quantidade de dados e servidores gerenciados, não é um problema para o Elasticsearch (_deal with it_).

Enfim, chega de conversa. Vamos ver como isso funciona na prática !

## Instalação

Instalar o Elasticsearch é a segunda coisa mais fácil do mundo de se fazer. A primeira é desinstalar. Vamos ver como se faz ?

Podemos fazer o download pelo repositório da Elastic atravéz de um gerenciador de pacotes como `dnf` ou `apt-get` ou podemos realizar o download do .zip no site da [Elastic]( https://www.elastic.co/downloads/elasticsearch ). Para conseguir realizar todo o treinamento, não se esqueça de garantir pelo menos 3GB de memória para sua máquina, VM ou container ok ?


Para este exemplo, vamos utilizar a segunda opção:

__1°__ - Realizar o download do .zip mais atual do Elasticsearch.

__2°__ - Realizar o unzip do pacote baixado em algum diretório do seu servidor.

__3°__ - Pronto, Elasticsearch instalado. Fácil né ? Agora vamos ver se tudo ocorreu bem ?

Dentro do diretório gerado após a descompactação, vamos executar:
```
$ nohup bin/elasticsearch &
```

Dessa forma, o processo do Elasticsearch se iniciará em background. Após alguns segundos (ou se você acompanhou o start pelo nohup.out), execute o seguinte comando:

```
$ curl -XGET http://localhost:9200/
```
Se um retorno parecido com esse ocorreu, quer dizer que tudo está funcionando como deveria:
```
{
  "name" : "XJWzjDi",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "ZH9GequzQX-oobJVGPlbjg",
  "version" : {
    "number" : "5.6.2",
    "build_hash" : "57e20f3",
    "build_date" : "2017-09-23T13:16:45.703Z",
    "build_snapshot" : false,
    "lucene_version" : "6.6.1"
  },
  "tagline" : "You Know, for Search"
}

```
Legal, mas o que realmente aconteceu aqui ? Lembra que o Elasticsearch possui uma API RESTful ? Basicamente, fizemos uma chamada __REST__ solicitando uma resposta para o nosso Elasticsearch através do método http __GET__ e como retorno à nossa requisição, recebemos uma resposta no formato __JSON__ com algumas informações básicas sobre a nossa instância de Elasticsearch. 

Analisando a resposta recebida, podemos ver o nome da nossa instância, o nome do cluster a qual ela pertence, o _uuid_ do cluster (identificador único universal) e dentro da tag "version" (perceba que mais um par de __"{ }"__ é aberto para esta tag), possuímos todas as informações sobre a versão do Elasticsearch instalada. Por fim, uma mensagem amigável: "You Know, for Search".

Trabalhando com o Elasticsearch, sempre usaremos o formato JSON, tanto para enviar requisições, quanto na resposta (como no exemplo acima). 

Sobre o JSON, imagine que você precise fazer duas aplicações totalmente distintas se comunicarem entre si ? Como fazer essa troca de informação ? O JSON por ser um formato padrão aceito pela maioria das linguagens de programação, pode ser utilizado para garantir que as duas aplicações possam "entender" o que a outra está querendo dizer de forma mais simples e legível se comparada com outros padrões como o _XML_ por exemplo. Vamos ver como este padrão funciona ?

```
{ # Abertura de sequência.
                            # O padrão é "campo", ":" e "valor".
                            # Caso hajam vários campos, colocar uma "," no final.
  "nome": "John Will",      # Strings precisam estar entre aspas. 
  "idade": 19,              # Inteiros são apresentados sem aspas.
  "deficiente": True,       # Booleanos são bem-vindos.
  "interesses": [ "musica", # Arrays sao representados entre [].
                "esportes"]
} # Fechamento da sequência. Fim do documento JSON.
```

Agora que sabemos como criar um _documento_ JSON, vamos entender a sintaxe utilizada para as chamadas REST:

```
curl -X<VERB> '<PROTOCOLO>://<HOST>:<PORTA>/<PATH>?<QUERY_STRING>' -d '<BODY>'
```

O __curl__ é uma ferramenta para transferência de dados através de uma URL. Usaremos ela para realizarmos as nossas requisições. Segue a explicação para os demais campos:

__VERB__ -> GET, POST, PUT, DELETE.

__PROTOCOLO__ -> http, https...

__HOST__ -> Servidor do Elasticsearch.

__PORTA__ -> Porta do Elasticsearch (9200 é a porta padrão).

__PATH__ -> Aonde você quer pesquisar, atualizar ou deletar (qual o _index_, _type_ e _document id_ ?).

__QUERY_STRING__ -> A pesquisa propriamente dita.

__BODY__ -> O documento JSON que você quer enviar ou utilizar como parâmetro de pesquisa. 

## Index, Type, Document ?

Agora que fizemos a instalação e garantimos que o nosso Elasticsearch está operacional, vamos entender na prática o que é um _index_, _type_ e um _document_.

Vamos começar a colocar alguns dados no nosso Elasticsearch ! Execute o comando abaixo:

```
$ curl -XPUT http://localhost:9200/mycompany/funcionarios/1 -d '
{
  "nome": "João Silva",
  "idade": 19,
  "Endereco": "Avenida da Magia",
  "Hobbies": ["Tocar guitarra", "Acampar com a familia"]
}'
```

Provavelmente você recebeu uma resposta parecida com esta:
```
{"_index":"mycompany","_type":"funcionarios","_id":"1","_version":1,"result":"created","_shards":{"total":2,"successful":1,"failed":0},"created":true}
```
Isto significa que o nosso documento JSON foi _indexado_ com sucesso. O verbo PUT basicamente diz para o Elasticsearch, "guarde este documento __NESTA__ url" (o POST se assemelha em funcionalidade, porém dizendo a frase: "guarde o documento __ABAIXO__ desta url". Entenderemos a diferença posteriormente).

Para facilitar o entedimento do conceito de _index_, _type_ e _document_, vamos fazer uma analogia com um banco de dados SQL padrão:

| MySQL        | Banco de Dados           | Tabela  | Chave Primária | Linha | Coluna
| ------------- |:-------------:| -----:|-----:|-----:|-----:|
| __Elasticsearch__        | __Index__           | __Type__  | __Id__ | __Document__ | __Field__
| ------------- | mycompany| funcionarios|1|Documento JSON|nome, idade...|


__Importante:__ Os termos indexar e index, possuem significados diferentes no universo do Elasticsearch e também, se diferenciam do conceito de índices utilizados em Banco de Dados. Indexar no Elasticsearch é o mesmo que adicionar um documento JSON e index é uma forma de separar dados de diferentes propósitos. 

Ok, temos o nosso primeiro funcionário João Silva indexado no nosso index mycompany ! Vamos fazer a nossa primeira consulta:

```
$ curl -XGET http://localhost:9200/mycompany/funcionarios/_search?pretty
```

Neste comando, chamamos a API ___search__, que é a API padrão de buscas do Elasticsearch (o parâmetro __?pretty__ é opcional e só serve para formatar a saída em JSON). Como não passamos nenhum parâmetro, a API sempre nos retorna os 10 primeiros resultados, que neste caso nos trouxe apenas o João (we're hiring). Sinta-se livre para criar e consultar mais funcionários para exercitar a sintáxe :) .

## Query-string x Query DSL 

No Elasticsearch existem três _tipos_ de pesquisa (full-text, estruturada e analítica) e duas _formas_ básicas de se pesquisar (query-string e query DSL).

Para este exemplo, utilize o script [tweets.sh](../elastic-stack/scripts/tweets.sh) para criar o indice twitter que irá conter diversos tweets de usuários diferentes. Agora que geramos a massa de dados, vamos as queries !

Primeiro, vamos ver como a query-string funciona. Vamos pesquisar todos os tweets do usuário Tom:

```
$ curl -XGET http://localhost:9200/twitter/tweet/_search?q=name:Tom
```

Apesar de parecer bastante simples de se utilizar, esse formato é o menos utilizado. A medida que colocamos mais parâmetros e condições, a busca começa a aparecer mais complicada do que realmente é. Por exemplo, vamos pesquisar pelo nome Phill no campo "name" __e__ lina no campo "tweet":

```
$ curl -XGET http://localhost:9200/twitter/tweet/_search?q=%2Bname%3Aphill+%2Btweet%3Alina
```

Agora, vamos realizar primeira pesquisa com a query DSL:

```
curl -XGET http://localhost:9200/twitter/tweet/_search?pretty -d '
{
  "query": {
    "match": { "name": "Tom"}
  }
}'
```

Neste formato, passamos um documento JSON como parâmetro de pesquisa. Antes de mais nada, vamos entender o que nos é retornado quando realizamos uma query. Utilizando o exemplo de retorno das queries acima, temos o resultado abaixo:

```
{
  "took" : 8,                 		# Tempo em milissegundos que a query demorou retornar.
  "timed_out" : false,        		# Houve Time Out na busca ? (True or False)
  "_shards" : {               		# Falaremos sobre shards mais tarde...
    "total" : 5,
    "successful" : 5,
    "failed" : 0
  },
  "hits" : {                
    "total" : 1,                	# Quantidade de documentos que foram encontrados.
    "max_score" : 0.25811607,   	# Falaremos sobre score mais tarde também...
    "hits" : [                  	# Dentro deste array, possuímos informações os resultados
      {
        "_index" : "twitter",   	# Qual o index do documento retornado.
        "_type" : "tweet",      	# Qual o type do documento retornado.
        "_id" : "14",           	# Qual o id do documento retornado.
        "_score" : 0.25811607,  	# Ó o score ai denovo...
        "_source" : {           	# Todos os dados do documento encontrado.
          "date" : "2014-09-23", 
          "name" : "Tom Michael",
          "tweet" : "Just one is sufficient.",
          "user_id" : 3
        }
      }
    ]
  }
}
```




