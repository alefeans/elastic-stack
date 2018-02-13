## Analítica

Finalizando os tipos de pesquisa existentes, temos a pesquisa analítica. O Elasticsearch possui uma funcionalidade chamada _aggregations_, que permite a geração de análises sofisticadas sobre os seus dados (se parece com o GROUP BY do SQL, só que bem mais poderoso). Vamos pesquisar quais são os interesses mais populares entre nossos funcionários. Mas antes, precisamos habilitar uma estrutura chamada __fielddata__ em nosso Elasticsearch, que vem desabilitada por padrão:

```
curl -XPUT http://localhost:9200/mycompany/_mapping/funcionarios -d '
{
  "properties": {
    "interesses": {
      "type":     "text",
      "fielddata": true
    }
  }
}'
```

Esta feature vem desabilitada por conta do consumo de memória que uma pesquisa de texto muito grande pode gerar (já que há outras formas de estruturar os seus dados à tornarem agregações mais simples de serem executadas). Como estamos apenas brincando com alguns dados fictícios, não há necessidade de se preocupar com isto agora ou se aprofundar neste assunto. Masssss, caso queira entender um pouco mais, acesse este link da [documentação da Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/fielddata.html).

Agora que habilitamos o fielddata, vamos fazer nossa pesquisa analítica:

```
curl -XGET http://localhost:9200/mycompany/funcionarios/_search?pretty -d '
{
"query" : {
    "match_all" : {}
},
"aggs" : {
    "maiores_interesses" : {
        "terms" : {
            "field" : "interesses"
        }
    }
}
}'
```

O parâmetro **"aggs"** é utilizado para descrevermos todas as nossas agregações que serão realizadas. O **"maiores_interesses"** foi um nome fictício (como um _apelido_), dado para o nosso conjunto de resultados e poderia ter sido qualquer outro (ex: total_de_interesses, interesses_gerais, etc). Após nomear o nosso conjunto de resultados, usamos o parâmetro **"terms"**, para descrevermos por qual(is) **"field(s)"** queremos agregar os resultados.

Para facilitar a visualização, vamos observar apenas o final do resultado obtido:

```
"aggregations" : {
"maiores_interesses" : {
  "doc_count_error_upper_bound" : 0,
  "sum_other_doc_count" : 0,
  "buckets" : [
    {
      "key" : "esportes",
      "doc_count" : 2
    },
    {
      "key" : "musica",
      "doc_count" : 2
    },
    {
      "key" : "filmes",
      "doc_count" : 1
    },
    {
      "key" : "games",
      "doc_count" : 1
    },
    {
      "key" : "musculacao",
      "doc_count" : 1
    }
  ]
}
}
}

```

Dentro de **"maiores_interesses"**, temos a separação dos resultados por **"buckets"**, que nos revelam a quantidade de documentos que foram encontrados fazendo menção a cada resultado. Algo que mais "embelezado" ficaria assim:

| Interesses        | Documentos Encontrados
| ------------- |:-------------:|
| Esportes | 2|
| Musica |2|
| Filmes | 1|
| Games | 1|
| Musculação | 1|

Ou seja, com uma simples pesquisa conseguimos encontrar fatores em comum sobre nossos funcionários e agora sabemos quais sãos os maiores interesses dentro de nossa empresa. Possuímos poucos dados para brincar até o momento, mas imagine em uma empresa com 5.000 funcionários. Será que conseguimos tirar algum proveito disso ? Será que conseguimos correlacionar nossos dados para encontrar benefícios que possam ser mais úteis para nossos colaboradores ? Pense só, temos poucos dados, mas já sabemos que a maioria dos funcionários gostam de "música" e "esportes".

Apesar de abordarmos tarefas simples com os tipos de pesquisa do Elasticsearch, a quantidade de operações, agregações e filtros possíveis são quase infinitos ! Tudo vai depender da quantidade de dados que você possui e a quantidade de regras que você quer especificar em suas buscas.

Próximo: [Shutdown](/pages/shutdown.md)
