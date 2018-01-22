## Full-Text

Na pesquisa full-text você simplesmente pesquisa o que você quer, sem passar nenhuma regra, agregação ou algo do tipo. Quando apresentarmos o Kibana, este tipo de pesquisa vai se apresentar de forma mais simples ainda, como uma pesquisa no Google. Vamos pesquisar as palavras "easy to use" no campo "tweet" do nosso index:

```
curl -XGET http://localhost:9200/twitter/tweet/_search?pretty -d '
{
"query": {
"match": {
    "tweet": "easy to use"
}
}
}'
```

Se você não fez nenhuma alteração no script [tweets.sh](scripts/tweets.sh), você deve estar visualizando 3 tweets agora, como estes aqui:

```
{
"took" : 8,
"timed_out" : false,
"_shards" : {
"total" : 5,
"successful" : 5,
"skipped" : 0,
"failed" : 0
},
"hits" : {
"total" : 3,
"max_score" : 1.9187583,
"hits" : [
  {
    "_index" : "twitter",
    "_type" : "tweet",
    "_id" : "6",
    "_score" : 1.9187583,
    "_source" : {
      "date" : "2018-09-16",
      "name" : "Tom Michael",
      "tweet" : "The Elasticsearch API is really easy to use",
      "user_id" : 1
    }
  },
  {
    "_index" : "twitter",
    "_type" : "tweet",
    "_id" : "11",
    "_score" : 0.84843254,
    "_sourc]e" : {
      "date" : "2018-09-21",
      "name" : "Lina Jones",
      "tweet" : "Elasticsearch is built for the cloud, easy to scale",
      "user_id" : 2
    }
  },
  {
    "_index" : "twitter",
    "_type" : "tweet",
    "_id" : "3",
    "_score" : 0.17669111,
    "_source" : {
      "date" : "2018-09-13",
      "name" : "Lina Jones",
      "tweet" : "Elasticsearch means full text search has never been so easy",
      "user_id" : 2
    }
  }
]
}
}
```

Talvez você não tenha reparado, mas você acabou de fazer uma pesquisa full text. Mas calma ai... porque eu tenho três respostas para a pequisa "easy to use" se em apenas um dos tweets eu realmente tenho as palavras "easy to use" ?

Bem, é ai que a graça (ou desgraça) do full text entra em ação. Repare que os três tweets retornados possuem a palavra "easy". Como a sua busca não possui nenhum filtro ou parametrização adicional, qualquer uma das trẽs palavras que compõe a sua busca (easy to use), serão pesquisadas no index informado . Porém no primeiro resultado (tweet do Tom Michael), vemos que o campo **"_score"** possui o número **"1.9187583"** como valor, correto ? Compare este número com o "_score" dos outros resultados. O que isso significa afinal ?

O Elasticsearch verifica a relevância de um documento pela proximidade da busca realizada. Como o primeiro resultado é o que mais se aproxima da busca feita, por possuir as três palavras pesquisadas, este documento recebe um número de _score mais alto do que os demais. É assim que o Elasticsearch mede a relevância de uma pesquisa feita com o resultado encontrado.

Este é o tipo de pesquisa mais simples de se fazer, porém é também o mais suscetível a falhas por acabar retornando resultados que podem não ser relevantes (e por conta do campo **"_all"** que será explicado em breve). Agora, se quisermos pesquisar a sequência exata "easy to use", podemos utilizar o recurso "match_phrase" em nossa busca:

```
curl -XGET http://localhost:9200/twitter/tweet/_search?pretty -d '
{
"query": {
"match_phrase": {
    "tweet": "easy to use"
}
}
}'
```
Repare que agora só obtivemos um retorno, correto ? Neste caso, a _frase_ é pesquisada como uma sequência única que deve ser respeitada.

Veremos em breve que geralmente realizamos pesquisas utilizando filtros e agregações para refinarmos nossas buscas. Isto melhora os resultados encontrados e geram retornos mais rápidos, já que o Elasticsearch terá que buscar a informação em um local mais específico, ao invés de ter que varrer um index inteiro para encontrar o que foi pedido. Também veremos que ao utilizar o Kibana, podemos realizar buscas sem ao menos digitar um campo específico (como o "tweet": no exemplo acima). No primeiro caso fica fácil de entender como o Elasticsearch interpreta a busca. "Aonde tiver o valor "x" no campo "y", retorne o resultado para o usuário". Mas e no segundo caso, onde você simplesmente fala "bla" pro Elasticsearch e espera que ele te mostre aonde tem o valor "bla" ? Mais tecnicamente falando, como o Elasticsearch entende o full-text quando não passamos nenhum campo como parâmetro ?

Ao indexarmos um documento, todos os valores dos campos do documento são indexados em uma única string em um campo default do Elasticsearch de nome "_all". Por exemplo, se eu estiver indexando o documento abaixo:

```
{
"nome": "Maria",
"idade": 28,
"endereco": "Rua Encantada",
"rg": 123456789,
"hobbies": ["Cantar", "Jogar xadrez"]
}
```

O campo "_all" deste documento ficaria assim:

```
{
"_all": "Maria 28 Rua Encantada 123456789 Cantar Jogar xadrez
}
```

Sendo assim, ao realizarmos uma busca full-text sem passarmos nenhum campo como parâmetro, o Elasticsearch realiza a pesquisa em todos os campos "_all" do index escolhido, o que é muito mais rápido do que ter que avaliar campo a campo de cada documento. Porém, pode acontecer de um campo diferente do que você quer buscar possuir um valor igual ao que você procura. Ficou estranho né ? Veja o exemplo abaixo:

```
{
"nome": "Carlos",
"idade": 21,
"endereco": "Rua Freitas",
"rg": 231496289,
"hobbies": "Jogar futebol"
},
{
"nome": "José",
"idade": 38,
"endereco": "Rua Carlos",
"rg": 987654321,
"hobbies": "Assistir Netflix"
}

```

Ao inserir estes dois documentos, o Elasticsearch geraria para cada um, as seguintes strings em seus respectivos *_all*:

```
{
"_all": "Carlos 21 Rua Freitas 231496289 Jogar futebol
},
{
"_all": "José 38 Rua Carlos 987654321 Assistir Netflix
}
```

Se eu quiser saber quantas pessoas de nome "Carlos" eu tenho no meu index e fizer uma pesquisa full-text para encontrar "Carlos", quantos retornos eu terei ? E se eu pesquisar por "Freitas", quantos retornos eu terei ?

Se o meu index só possuir estes dois documentos apenas, o retorno da nossa pesquisa seria: **dois** Carlos e **um** Freitas, mesmo eu só possuindo **um** Carlos e **nenhum** Freitas.

Estamos entendidos com o full-text ?
