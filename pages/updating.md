## Atualizando

Documentos no Elasticsearch são entidades _imutáveis_. Caso haja a necessidade de atualizar um documento existente, nós o _reindexamos_ ou o substituimos completamente, utilizando a mesma API que usamos para inserir um documento. Vamos alterar o endereço da funcionária "Maria" de id "2":

```
curl -XPUT http://localhost:9200/mycompany/funcionarios/2 -d '
{
  "nome": "Maria Costa",
  "idade": 34,
  "endereco": "Avenida do Amor",
  "hobbies": ["Ouvir musica", "Andar de bicicleta"],
  "interesses": ["esportes", "musica"]
}'
```

Observe a resposta do Elasticsearch ao seu comando:

```
{"_index":"mycompany","_type":"funcionarios","_id":"2","_version":2,"result":"updated","_shards":{"total":2,"successful":1,"failed":0},"created":false}%
```

Podemos ver que o campo **"_version"** foi incrementado e que o campo **"created"** possui o valor _false_ (pois o documento que atualizamos já existia anteriormente). Por debaixo dos panos, o Elasticsearch marca o documento antigo como removido e adiciona o novo documento inteiro.

Existe uma forma de realizar atualizações parciais utilizando a API **_update**. Este tipo de atualização também segue a mesma regra descrita para o update total, diferenciando-se apenas nos fatos de que é possivel atualizar os campos necessários sem precisar digitar o documento inteiro como parâmetro e que o processo acontece no "interior de um shard", o que é transparente para nós usuários. Por exemplo:

```
curl -XPOST http://localhost:9200/mycompany/funcionarios/2/_update -d '
{
  "doc": {
    "idade": 35
  }
}'
```

Podemos utilizar esta mesma API para acrescentarmos mais campos em nossos documentos. Faça o teste, altere o campo __"idade" : 35__ por um campo que não exista no nosso documento, atribuia um valor de sua preferência e acrescente-o no documento acima.

Próximo: [Node e Cluster](/pages/node_cluster.md)
