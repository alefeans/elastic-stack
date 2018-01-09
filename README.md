# Elastic Stack para iniciantes

   O objetivo desse repositório é apresentar o `Elastic Stack` de uma forma simples e amigável para quem está iniciando no assunto.

   Quando comecei a estudar sobre o Elastic Stack, encontrei diversos conteúdos que traziam explicações muito "pesadas" e que em alguns segundos de leitura, te levavam a realizar várias pesquisas para entender o significado de cada sub-tópico, conceito ou ferramenta adjacente.


   Sendo assim, decidi criar este repositório com uma linguagem mais informal e direta para explicar a _stack_, sem deixar de apresentar os conceitos essenciais. Não se preocupe se em alguns momentos aparecerem termos confusos que ainda não foram explicados, pois ao longo do treinamento eles se tornarão claros para você :)


## Elasticsearch


  O `elasticsearch` é uma ferramenta de buscas _open source_ desenvolvido em Java, assim como é uma solução NoSQL de armazenamento de dados, ou seja, não segue os padrões de bancos de dados SQL comuns (como o MySQL, por exemplo). Ele tem como base o [Apache Lucene](https://github.com/apache/lucene-solr), que é uma biblioteca Java de pesquisa _full text_ e que é também, o motor de busca open source mais avançado oferecido hoje em dia. Porém, usar todo o poder de fogo do Lucene exige um certo esforço, afinal, por ser apenas uma biblioteca, você precisa trabalhar com o Java para integrá-lo com sua aplicação (e esta tarefa pode apresentar uma certa complexidade).

  O Elasticsearch no entanto, se aproveita do Lucene na _indexação_ e pesquisa de documentos, retirando a sua complexidade através de uma API RESTful super fácil de se utilizar. Além disso, vamos citar algumas características que o tornam uma ferramenta excelente e extremamente veloz:

* Uma API RESTful para inclusão, remoção e acesso aos dados utilizando o padrão JSON.
* Totalmente livre de normalização.
* Qualquer palavra _indexada_ no elasticsearch pode ser pesquisada da mesma forma que você faz uma busca no Google.
* Altamente escalável (feito para o _Cloud Computing_).
* Permite pesquisas estruturadas e analíticas em _real-time_.
* Possui uma inteligência interna que entrega o melhor resultado em relação a busca feita (análise de relevância).
* Extremamente rápido. Explicaremos o por quê `:)`

## Onde usar ?

  Tudo bem, ficou claro o que o Elasticsearch é. Mas aonde e como eu posso utilizá-lo ?

__Exemplo 1:__
Bem, um dos cenários mais comuns é utiliza-lo como um agregador de logs em conjunto com o Logstash e o Kibana, que são outras ferramentas da organização _Elastic_, formando o que chamamos atualmente de `Elastic Stack` (o acrônimo `ELK` não é mais utilizado). Através desta _stack_, possuímos uma ferramenta de busca e armazenamento de documentos (Elasticsearch), uma ferramenta de agregação, filtro e envio de dados (Logstash) e por fim, uma _web view_ para pesquisa e análise gráfica dos dados já armazenados (o nosso querido Kibana).

A partir disso, você sysadmin ou desenvolvedor, pode centralizar qualquer tipo de log gerado por _"qualquer coisa que gere log"_ e então, realizar análises, pesquisas de baseline ou montar dashboards de métricas pré-definidas.

Vamos imaginar a seguinte situação: você é responsável por um sistema computacional que possui 30 servidores e em cada um, 30 _microserviços_ diferentes. De repente, algum problema crítico acontece com este sistema e você precisa descobrir o que ocorreu. Por instinto, você irá ler as logs do sistema para tentar entender o que houve, certo ? Mas... será que você pode se dar ao luxo de logar em 30 servidores e procurar a log entre 30 microserviços diferentes em um momento de crise ?

Agora, se você possuir um ponto central que lhe permita realizar uma busca através de uma sintaxe super simples ou ainda que lhe permita gerar um gráfico que contabilize a quantidade de vezes que esse erro ocorre, será muito mais fácil de identificar o problema não concorda ? Prazer, `Elastic Stack`.

__Exemplo 2:__
Outra forma de se usar o Elasticsearch é como uma solução NoSQL. Como ele escala horizontalmente com extrema facilidade (escalar horizontalmente nada mais é do que adicionar novos servidores com instâncias de Elasticsearch atuando como se fosse uma, representando o que chamamos de _cluster_), é comum ver empresas utilizando-o como um _Big Data_, já que a quantidade de dados e servidores gerenciados, não é um problema para o Elasticsearch (_deal with it_). Neste caso de uso, o Logstash pode não existir na composição da stack, mas o Kibana pode ainda ser utilizado para visualizar os dados graficamente e gerar dashboards personalizados.

Enfim, chega de conversa. Vamos ver como isso funciona na prática !

## Instalação

Instalar o Elasticsearch é a segunda coisa mais fácil do mundo de se fazer. A primeira é desinstalar. Vamos ver como se faz ?

Podemos fazer o download pelo repositório da Elastic atravéz de um gerenciador de pacotes como `dnf` ou `apt-get`, ou podemos realizar o download do .zip no site da [Elastic]( https://www.elastic.co/downloads/elasticsearch ). Para conseguir realizar todo o treinamento, não se esqueça de garantir pelo menos 3GB de memória para sua máquina, VM ou container, ok ?


Para este exemplo, vamos utilizar a segunda opção:

__1°__ - Realizar o download do .zip mais atual do Elasticsearch.

__2°__ - Realizar o unzip do pacote baixado em algum diretório do seu servidor.

__3°__ - Pronto, Elasticsearch instalado. Fácil né ? Agora vamos ver se tudo ocorreu bem ?

__OBS:__ Acredito na retrocompatibilidade, mas para este guia estamos utilizando especificamente a versão 5.6.5.

Dentro do diretório gerado após a descompactação, vamos executar:
```
nohup bin/elasticsearch &
```

Dessa forma, o processo do Elasticsearch se iniciará em background. Após alguns segundos (ou se você acompanhou o start pelo nohup.out), execute o seguinte comando:

```
curl -XGET http://localhost:9200/
```
Se você recebeu um retorno parecido com esse, quer dizer que tudo está funcionando como deveria:
```
{
  "name" : "XJWzjDi",                           # Nome da instância (iremos alterar isto mais tarde).
  "cluster_name" : "elasticsearch",             # Nome do cluster que a nossa instância pertence.
  "cluster_uuid" : "ZH9GequzQX-oobJVGPlbjg",    # Identificador universal do seu cluster (como um CPF do seu cluster).
  "version" : {                                 # Dentro desta "tag" temos todas as informações sobre versão de produto.
    "number" : "5.6.5",                         # Versão do Elasticsearch.
    "build_hash" : "57e20f3",                   # "ID" da geração deste pacote de Elasticsearch.
    "build_date" : "2017-09-23T13:16:45.703Z",  # Data de geração deste pacote.
    "build_snapshot" : false,                   # Irrelevante (é irrelevante sim, para de reclamar).
    "lucene_version" : "6.6.1"                  # Versão do Lucene utilizada.
  },
  "tagline" : "You Know, for Search"            # Uma resposta amigável do Elasticsearch.
}

```
Legal, mas o que realmente aconteceu aqui ? Lembra que o Elasticsearch possui uma API RESTful ? Lembra o que é API RESTful ? Lembra o que é REST ? Não ? Que vergonha...

Falando da forma mais simples possível, uma API RESTful é uma API que faz/aceita chamadas REST e REST, representa um conjunto de operações padronizadas que permitem a troca de informação entre sistemas através de simples métodos HTTP.

No exemplo acima, fizemos uma chamada __REST__ solicitando uma resposta para o nosso Elasticsearch através do método http __GET__ e como retorno à nossa requisição, recebemos uma resposta no formato __JSON__ com algumas informações básicas sobre a nossa instância de Elasticsearch.

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

Agora que fizemos a instalação e garantimos que o nosso Elasticsearch está operacional, vamos entender na prática o que é um _index_, _type_ e um _document_. Para isto, vamos começar a colocar alguns dados no nosso Elasticsearch ! Execute o comando abaixo:

```
curl -XPUT http://localhost:9200/mycompany/funcionarios/1 -d '
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
Isto significa que o nosso documento JSON foi _indexado_ com sucesso. O verbo PUT utilizado, basicamente diz para o Elasticsearch, "guarde este documento __NESTA__ url" (o POST se assemelha em funcionalidade, porém dizendo a frase: "guarde o documento __ABAIXO__ desta url". Entenderemos melhor a diferença posteriormente).

Para facilitar o entedimento do conceito de _index_, _type_ e _document_, vamos fazer uma analogia com um banco de dados SQL padrão:

| MySQL        | Banco de Dados           | Tabela  | Chave Primária | Linha | Coluna
| ------------- |:-------------:| -----:|-----:|-----:|-----:|
| __Elasticsearch__        | __Index__           | __Type__  | __Id__ | __Document__ | __Field__
| ------------- | mycompany| funcionarios|1|Documento JSON|nome, idade...|


__Importante:__ Os termos "indexar" e "index" possuem significados diferentes no universo do Elasticsearch e também, se diferenciam do conceito de índices utilizados em Banco de Dados. Indexar no Elasticsearch é o mesmo que adicionar um documento JSON (como realizar um INSERT), e index é uma forma de separar logicamente dados de diferentes propósitos.

Ok, temos o nosso primeiro funcionário João Silva __indexado__ no nosso __index__ mycompany ! Vamos fazer a nossa primeira consulta:

```
curl -XGET http://localhost:9200/mycompany/funcionarios/_search?pretty
```

Neste comando, chamamos a API ___search___, que é a API padrão de buscas do Elasticsearch (o parâmetro __?pretty__ é opcional e só serve para formatar a saída em JSON). Como não passamos nenhum parâmetro, a API sempre nos retorna os 10 primeiros resultados, que neste caso nos trouxe apenas o João (we're hiring). Sinta-se livre para criar e consultar mais funcionários para exercitar a sintáxe :) .

## Tipos e Formas de Pesquisa

No Elasticsearch existem três _tipos_ de pesquisa (full-text, estruturada e analítica) e duas _formas_ básicas de se pesquisar (query-string e query DSL).

Para este exemplo, utilize o script [tweets.sh](https://github.com/alefeans/elastic-stack/tree/master/scripts/tweets.sh) para criar o índice twitter que irá conter diversos tweets de usuários diferentes. Caso queira visualizar os índices existentes no seu Elasticsearch, utilize a API **_cat**:

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

Perceba que mesmo sendo uma pesquisa relativamente simples, a string de pesquisa é menos legível e mais "encriptada".

Agora, vamos realizar a primeira pesquisa feita no index twitter anteriormente, utilizando agora, a __query DSL__:

```
curl -XGET http://localhost:9200/twitter/tweet/_search?pretty -d '
{
  "query": {
    "match": { "name": "Phill"}
  }
}'
```

Neste formato, passamos um documento JSON como parâmetro de pesquisa. Antes de mais nada, vamos entender o que nos é retornado quando realizamos uma pesquisa. Utilizando o exemplo de retorno da query acima, temos o resultado abaixo:

```
{
  "took" : 8,                 		# Tempo em milissegundos que a query demorou para  retornar.
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

## Full-Text

Na pesquisa full text você simplesmente pesquisa o que você quer, sem passar nenhuma regra, agregação ou algo do tipo. Quando apresentarmos o Kibana, este tipo de pesquisa vai se apresentar de forma mais simples ainda, como uma pesquisa no Google. Vamos pesquisar as palavras "easy to use" no campo "tweet" do nosso index:

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

Se você não fez nenhuma alteração no script [tweets.sh](https://github.com/alefeans/elastic-stack/tree/master/scripts/tweets.sh), você deve estar visualizando 3 tweets agora, como estes aqui:

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
        "_source" : {
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

Bem, é ai que a graça (ou desgraça) do full text entra em ação. No primeiro resultado (tweet do Tom Michael), vemos que o campo "_score" possui o número "1.9187583" como valor, correto ? Compare este número com o "_score" dos outros resultados. O que isso significa afinal ?

O Elasticsearch verifica a relevância de um documento pela proximidade da busca realizada. Como o primeiro resultado é o que mais se aproxima da busca feita, este recebe um número de _score mais alto do que os demais. É assim que o Elasticsearch mede a relevância de uma pesquisa feita com o resultado encontrado.

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

Veremos em breve que geralmente realizamos pesquisas utilizando filtros e agregações para refinarmos nossas buscas. Também veremos que ao utilizar o Kibana, podemos realizar buscas sem ao menos digitar um campo específico (como o "tweet": no exemplo acima). No primeiro caso fica fácil de entender como o Elasticsearch interpreta a busca. "Aonde tiver o valor "x" no campo "y", retorne o resultado para o usuário". Mas e no segundo caso, onde você simplesmente fala "bla" pro Elasticsearch e espera que ele te mostre aonde tem o valor "bla" ? Mais tecnicamente falando, como o Elasticsearch entende o full-text quando não passamos nenhum campo como parâmetro ?

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

Sendo assim, ao realizarmos uma busca full-text sem passarmos nenhum campo como parâmetro, o Elasticsearch realiza a pesquisa em todos os campos "_all" do index escolhido.

Estamos entendidos com o full-text ?

## Estruturada

Uma pesquisa estruturada diz respeito à pesquisas que possuem algum tipo de parametrização/regra envolvida. Para este exemplo, vamos usar o script [funcs.sh](https://github.com/alefeans/elastic-stack/tree/master/scripts/funcs.sh) para gerar os dados no nosso esquecido índice "mycompany".

Após executar o script, execute a pesquisa estrutura abaixo. Tente interpretá-la juntamente com o seu resultado antes de ler a explicação, ok ?

```
curl -XGET http://localhost:9200/mycompany/_search\?pretty -d '
{
  "query": {
    "bool": {
      "must": {
        "match": {
          "nome":   "Silva"       
           }
        },     
      "filter":  {
       "range": {
         "idade": {"gt": 30}
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
__3°__ - O **"must"** é um parâmetro de "bool" que significa que o valor __DEVE__ ser encontrado em todos os resultados. Isto contribui para um **_score** mais preciso (lembra dele ?).
__4°__ - Dentro da cláusula "must" temos o parâmetro "match" já usado para pesquisas mais simples. Este tem a simples tarefa de relacionar um campo com um valor.
__5°__ - Perceba que há uma "**,**" antes do parâmetro **"filter"**. Em JSON, a vírgula faz a separação de múltiplos campos lembra ? Estamos passando duas cláusulas para o parâmetro "bool" avaliar: **"must"** e **"filter"**, sendo assim, precisamos separá-los por vírgula.
__6°__ - Dentro de "filter", passamos um "range" para o nosso campo "idade", que neste caso, deve ser maior que 30 (**gt** = greater than).

Após compreendermos cada passo, a tradução final da query seria esta:
_"Elasticsearch, quais são os funcionários com mais de 30 anos que tem Silva no nome ?"_

A medida que as pesquisas se tornam maiores e mais específicas, mais campos e parâmetros são encadeados para satisfazer as condições da busca. Existem diversos argumentos disponíveis para a refinação de queries que são facilmente encontrados na documentação da [Elastic](https://www.elastic.co/guide/index.html)

## Analítica

Finalizando os tipos de pesquisa existentes, temos a pesquisa analítica. O Elasticsearch possui uma funcionalidade chamada _aggregations_, que permite a geração de análises sofisticadas sobre os seus dados (se parece com o GROUP BY do SQL, só que bem mais poderoso). Vamos pesquisar os interesses mais populares entre nossos funcionários:



__OBS:__ Apesar de abordarmos tarefas simples com os tipos de pesquisa do Elasticsearch, a quantidade de operações, agregações e filtros possíveis são quase infinitos ! Tudo vai depender da quantidade de dados que você possui e a quantidade de regras que você quer especificar em suas buscas.
