## Index, Type, Document ?

Agora que fizemos a instalação e garantimos que o nosso Elasticsearch está operacional, vamos entender na prática o que é um _index_, _type_ e um _document_. Para isto, vamos começar a colocar alguns dados no nosso Elasticsearch ! Execute o comando abaixo:

```
curl -XPUT -H "Content-Type: application/json" http://localhost:9200/mycompany/funcionarios/1 -d '
{
  "nome": "João Silva",
  "idade": 19,
  "endereco": "Avenida da Magia",
  "hobbies": ["Tocar guitarra", "Acampar com a familia"],
  "interesses": "musica"
}'
```

Provavelmente você recebeu uma resposta parecida com esta:

```
{"_index":"mycompany","_type":"funcionarios","_id":"1","_version":1,"result":"created","_shards":{"total":2,"__successful__":1,"failed":0},"created":true}
```

Isto significa que o nosso documento JSON foi _indexado_ com sucesso. O _verbo_ PUT utilizado, basicamente diz para o Elasticsearch: "guarde este documento __NESTA__ url" (o POST se assemelha em funcionalidade, porém dizendo a frase: "guarde o documento __ABAIXO__ desta url". Entenderemos melhor a diferença posteriormente).

Para facilitar o entedimento do conceito de _index_, _type_ e _document_, vamos fazer uma analogia com um banco de dados SQL padrão:

| MySQL        | Banco de Dados | Tabela  | Chave Primária | Linha | Coluna
| ------------- |:-------------:| -----:|-----:|-----:|-----:|
| __Elasticsearch__        | __Index__           | __Type__  | __Id__ | __Document__ | __Field__
| ------------- | mycompany| funcionarios|1|Documento JSON|nome, idade...|


__OBS:__ Os termos "indexar" e "index" possuem significados diferentes no universo do Elasticsearch, e também se diferenciam do conceito de _índices_ utilizados em [Banco de Dados](https://pt.wikipedia.org/wiki/%C3%8Dndice_(estruturas_de_dados)). Indexar no Elasticsearch é o mesmo que adicionar um documento JSON (como realizar um INSERT), e index é uma forma de separar logicamente dados de diferentes propósitos.

Ok, temos o nosso primeiro funcionário João Silva __indexado__ no nosso __index__ mycompany ! Vamos fazer a nossa primeira consulta:

```
curl -XGET http://localhost:9200/mycompany/funcionarios/_search?pretty
```

Com o comando acima, chamamos a API padrão de buscas do Elasticsearch **_search** (o parâmetro __?pretty__ é opcional e só serve para formatar a resposta em JSON). Como não passamos nenhum parâmetro, a API sempre nos retorna os 10 primeiros resultados encontrados, que neste caso nos trouxe apenas o João (_we're hiring_). Sinta-se livre para criar e consultar mais funcionários para exercitar a sintáxe :) .

Próximo: [Tipos e Formas de Pesquisa](/pages/types_forms.md)
