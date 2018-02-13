## Tipos e Formas de Pesquisa

No Elasticsearch existem três _tipos_ de pesquisa (full-text, estruturada e analítica) e duas _formas_ básicas de se pesquisar (query-string e query DSL).

Para este exemplo, utilize o script [tweets.sh](/scripts/tweets.sh) para criar o índice twitter que irá conter diversos tweets de usuários diferentes. Caso queira visualizar os índices existentes no seu Elasticsearch, utilize a API **_cat**:

```
curl -XGET http://localhost:9200/_cat/indices?v
```

Não se preocupe com todas as informações retornadas (nem se estiver com seus índices com o "health" em "yellow"), tome por nota apenas a informação dos índices que você possui (mycompany e twitter).

Agora que geramos a massa de dados, vamos as queries ! Primeiro, vamos ver como a query-string funciona. Vamos pesquisar todos os tweets do usuário "Phill":

```
curl -XGET http://localhost:9200/twitter/tweet/_search?q=name:Phill
```

Apesar de parecer bastante simples de se utilizar, esse formato é o menos utilizado. A medida que colocamos mais parâmetros e condições, a busca começa a aparecer mais complicada do que realmente é. Por exemplo, vamos pesquisar pelo nome "Tom" no campo "name" __e__ "lina" no campo "tweet":

```
curl -XGET http://localhost:9200/twitter/tweet/_search?q=%2Bname%3Atom+%2Btweet%3Alina
```

Perceba que mesmo sendo uma pesquisa relativamente simples, a string de pesquisa se tornou um pouco menos _legível_. Agora, vamos realizar a primeira pesquisa feita no index twitter anteriormente, utilizando a __query DSL__:

```
curl -XGET http://localhost:9200/twitter/tweet/_search?pretty -d '
{
  "query": {
    "match": { "name": "Phill" }
  }
}'
```

Neste formato, passamos um documento JSON como parâmetro de pesquisa. Antes de mais nada, vamos entender o que nos é retornado quando realizamos uma pesquisa. Utilizando o exemplo de retorno da query acima, temos o resultado abaixo:

```
{
"took" : 8,                 		# Tempo em milissegundos que a query demorou para retornar.
"timed_out" : false,        		# Houve Time Out na busca (True or False) ?
"_shards" : {               		# Falaremos sobre shards mais tarde...
"total" : 5,
"successful" : 5,
"failed" : 0
},
"hits" : {                
"total" : 1,                	# Quantidade de documentos que foram encontrados.
"max_score" : 0.25811607,   	# Falaremos sobre score mais tarde também...
"hits" : [                  	# Dentro deste array, possuímos todos os resultados encontrados.
  {
    "_index" : "twitter",   	# Qual o index do documento.
    "_type" : "tweet",      	# Qual o type do documento.
    "_id" : "14",           	# Qual o id do documento.
    "_score" : 0.25811607,  	# Ó o score ai denovo...
    "_source" : {           	# Todos os dados do documento encontrado.
      "date" : "2018-09-23",
      "name" : "Phill Matt",
      "tweet" : "Just one is sufficient.",
      "user_id" : 3
    }
  }
]
}
}
```

Inicialmente pode parecer estranho ou até um pouco frustrante ter que decifrar um documento JSON. Você tem que parar, analisar, entender o que está dentro de uma tag ou de outra... mas a medida que vamos praticando e brincando mais com o Elasticsearch, esta tarefa vai se tornando menos dolorosa ("_if it hurts, do it more often_", Martin Fowler). E relaxa, daqui a pouco estaremos usando o Kibana para nos ajudar nesta tarefa :)

Agora vamos aos três tipos básicos de pesquisa...

Próximo: [Full-text](/pages/full-text.md)
