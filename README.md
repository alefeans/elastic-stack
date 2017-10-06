
  # Elastic Stack para iniciantes
   
   O objetivo desse repositório é apresentar o `Elastic Stack` de uma forma simples e amigável para quem está querendo começar a utilizar as ferramentas no dia-a-dia. 
   
   No meu estudo sobre a _stack_, eu encontrei diversos artigos e livros que traziam explicações muito "pesadas" e que em alguns segundos de leitura, te faziam abrir várias janelas no browser para pesquisar o significado de cada sub-tópico, conceito ou ferramenta adjacente para definir o que o `ELK` é.
   
   Sendo assim, esse repositório será o mais direto possível, mas sem deixar os conceitos essenciais para trás. Inicialmente, vamos conceituar o que cada ferramenta é e o seu propósito.
   
   

## Elasticsearch


  O `elasticsearch` é uma ferramenta de buscas _open source_ desenvolvido em Java, assim como é uma solução NoSQL. Ele tem como base o [Apache Lucene](https://github.com/apache/lucene-solr) que é uma biblioteca Java de pesquisa _full text_ (texto comum, sem formatação ou parametrização). Lucene é sem dúvida, o motor de busca mais avançado oferecido hoje em dia (contando com Open Source e ferramentas proprietárias). Porém, Lucene é apenas uma library. Para usar o seu poder de fogo, você precisa trabalhar com o Java para integrar o Lucene com sua aplicação. 
  
  O `elasticsearch` no entanto, se aproveita do Lucene na _indexação_ e pesquisa de documentos, retirando a sua complexidade através de uma API RESTful super fácil de se utilizar. Mas não é só isso. Vamos citar algumas características que o tornam uma ferramenta excelente e extremamente veloz:
  
* Uma _API Restful_ para inclusão, remoção e acesso aos dados utilizando o padrão JSON.
* Livre de normalização.
* Qualquer palavra _indexada_ no elasticsearch é pesquisável como uma "busca no Google".
* Altamente escalável (feito para o _Cloud_).
* Permite pesquisas estruturadas e analíticas em _real-time_.
* Possui uma inteligência interna que entrega o melhor resultado em relação a busca feita (análise de relevância).
* Extremamente rápido. Explicaremos o por quê `:)` 

E o que isso tudo significa ? Bem, nada melhor do que mostrar na prática não é mesmo ?

## Instalação do Elasticsearch
