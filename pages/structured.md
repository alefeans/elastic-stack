## Estruturada

Uma pesquisa estruturada diz respeito à pesquisas que possuem algum tipo de parametrização/regra envolvida. Para este exemplo, vamos usar o script [funcs.sh](/scripts/funcs.sh) para gerar mais dados no nosso _esquecido_ índice "mycompany".

Após executar o script, faça a pesquisa estruturada abaixo. Tente interpretá-la juntamente com o seu resultado antes de ler a explicação, ok ?

```
curl -XGET http://localhost:9200/mycompany/_search\?pretty -d '
{
  "query": {
    "bool": {
      "must": {
        "match": {
          "nome": "Silva"
        }
     },
      "filter": {
        "range": {
          "idade": {
            "gt": 30
          }
        }
      }
    }
  }
}
'
```

E ai, conseguiu ? Se a resposta for não, fique tranquilo, algumas coisas novas apareceram por aqui. Vamos entendê-las melhor:

__1°__ - Iniciamos o parâmetro "query".

__2°__ - O parâmetro de busca "bool" inicia uma combinação de resultados entre queries, indicando um ou mais filtros à serem respeitados.

__3°__ - O **"must"** é um parâmetro de "bool" que significa que o valor __DEVE__ ser encontrado em todos os resultados. Isto contribui para um **_score** mais preciso.

__4°__ - Dentro da cláusula "must" temos o parâmetro "match" já usado para pesquisas mais simples. Este tem a simples tarefa de relacionar um campo com um valor.

__5°__ - Perceba que há uma "**,**" antes do parâmetro **"filter"**. Em JSON, a vírgula faz a separação de múltiplos campos. Estamos passando duas cláusulas para o parâmetro "bool" avaliar: **"must"** e **"filter"**, sendo assim, precisamos separá-los por vírgula.

__6°__ - Dentro de "filter", passamos um "range" para o nosso campo "idade", que neste caso, deve ser maior que 30 (**gt** = greater than).

Após compreendermos cada passo, a tradução final da query para a nossa linguagem seria esta:
_"Elasticsearch, quais são os funcionários com mais de 30 anos que tem Silva no nome ?"_

A medida que as pesquisas se tornam maiores e mais específicas, mais campos e parâmetros são encadeados para satisfazer as condições da busca. Existem diversos argumentos disponíveis para a refinação de queries que são facilmente encontrados na documentação da [Elastic](https://www.elastic.co/guide/index.html). Alguns serão abordados mais a frente, após aprendermos o básico sobre os tipos de busca.

Próximo: [Analítica](/pages/analytics.md)
