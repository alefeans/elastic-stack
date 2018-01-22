##### Deletando

Para remover algum dado do Elasticsearch, utilizamos o verbo HTTP, __DELETE__ e passamos o caminho completo do dado, conforme o exemplo abaixo:

```
curl -XDELETE http://localhost:9200/mycompany/funcionarios/1

{"found":true,"_index":"mycompany","_type":"funcionarios","_id":"1","_version":2,"result":"deleted","_shards":{"total":2,"successful":1,"failed":0}}
```
Se pesquisarmos pelo funcionário de id "1", veremos que o mesmo não é mais encontrado:
```
curl -XGET http://localhost:9200/mycompany/funcionarios/1

{"_index":"mycompany","_type":"funcionarios","_id":"1","found":false}
```

Tenha bastante cuidado ao apagar um dado, pois caso você esqueça de passar o "type" e o "id" do documento, podemos acabar apagando um index inteiro (types estão seguros nesta situação, pois estes são removidos utilizando um método chamado "[delete_by_query](https://www.elastic.co/guide/en/elasticsearch/reference/6.1/docs-delete-by-query.html)").

Caso queira contratar o funcionário "João Silva" denovo, verifique a seção do treinamento de nome "Index, Type, Document ?" e execute a inserção novamente.
