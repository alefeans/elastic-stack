# Elastic Stack para iniciantes
   
   O objetivo desse repositório é apresentar o `Elastic Stack` de uma forma simples e amigável para quem está desejando utilizar as ferramentas no dia-a-dia. 
   
   No meu estudo sobre a _stack_, eu encontrei diversos artigos e livros que traziam explicações muito "pesadas" e que em alguns segundos de leitura, te faziam abrir várias janelas no browser para pesquisar o significado de cada sub-tópico, conceito ou ferramenta adjacente para definir o que o `Elastic Stack` é.
   
   Sendo assim, esse repositório será o mais direto possível, mas sem deixar os conceitos essenciais para trás. Inicialmente, vamos conceituar o que cada ferramenta é e o seu propósito.
   
   

## Elasticsearch


  O `elasticsearch` é uma ferramenta de buscas _open source_ desenvolvido em Java, assim como é uma solução NoSQL. Ele tem como base o [Apache Lucene](https://github.com/apache/lucene-solr) que é uma biblioteca Java de pesquisa _full text_ (texto comum, sem formatação ou parametrização). Lucene é sem dúvida, o motor de busca mais avançado oferecido hoje em dia (contando com Open Source e ferramentas proprietárias). Porém, Lucene é apenas uma library. Para usar o seu poder de fogo, você precisa trabalhar com o Java para integrar o Lucene com sua aplicação. 
  
  O Elasticsearch no entanto, se aproveita do Lucene na _indexação_ e pesquisa de documentos, retirando a sua complexidade através de uma API RESTful super fácil de se utilizar. Mas não é só isso. Vamos citar algumas características que o tornam uma ferramenta excelente e extremamente veloz:
  
* Uma API RESTful para inclusão, remoção e acesso aos dados utilizando o padrão JSON.
* Livre de normalização.
* Qualquer palavra _indexada_ no elasticsearch é pesquisável como uma "busca no Google".
* Altamente escalável (feito para o _Cloud_).
* Permite pesquisas estruturadas e analíticas em _real-time_.
* Possui uma inteligência interna que entrega o melhor resultado em relação a busca feita (análise de relevância).
* Extremamente rápido. Explicaremos o por quê `:)` 

## Onde usar ?

  Tudo bem, ficou claro o que o Elasticsearch é. Mas aonde e como eu posso utilizá-lo ? 
  
__Exemplo 1:__
Bem, um dos cenários mais comuns é utiliza-lo como um agregador de logs em conjunto com o Logstash e o Kibana, que são outras ferramentas da organização _Elastic_, formando o que chamamos atualmente de `Elastic Stack` (o acrônimo `ELK` não é mais utilizado). Através desta _stack_ de ferramentas, possuímos uma ferramenta de busca e armazenamento de documentos (Elasticsearch), uma ferramenta de agregação, filtro e envio de dados (fazendo uma analogia, o Logstash funciona como um "[ETL](https://pt.wikipedia.org/wiki/Extract,_transform,_load)") e por fim, uma _web view_ para pesquisa e análise gráfica dos dados já armazenados (o nosso querido Kibana).

A partir disso, você sysadmin ou desenvolvedor, pode centralizar qualquer tipo de log gerado por "qualquer coisa que gere log" e então, realizar análises, pesquisas de baseline ou montar dashboards de métricas pré-definidas. 

Exemplificando, imagine que você possua um ambiente com 30 servidores e em cada um, 30 _microserviços_ diferentes. Caso você esteja pesquisando por um erro específico gerado no log de um determinado microserviço, será bem complicado se situar devido a quantidade de locais à se olhar. Se você possuir um ponto central que lhe permita realizar uma busca através de uma sintaxe super simples ou ainda que lhe permita gerar um gráfico que contabilize a quantidade de vezes que esse erro ocorre, será muito mais fácil não concorda ? Prazer, `Elastic Stack`.

__Exemplo 2:__
Outra forma de se usar o Elasticsearch é como uma solução NoSQL. Como ele escala horizontalmente com extrema facilidade (escalar horizontalmente nada mais é do que, adicionar novos servidores com instâncias de Elasticsearch, atuando como se fosse uma (_cluster_)), é comum ver empresas utilizando-o como um _Big Data_, já que a quantidade de dados e servidores não é um problema para o Elasticsearch (_deal with it_).

Enfim, chega de conversa. Vamos ver como isso funciona na prática !

## Instalação

Instalar o Elasticsearch é a _segunda coisa_ mais fácil do mundo. A primeira é desinstalar. Vamos ver como se faz ?

Podemos fazer o download pelo repositório da Elastic atravéz de um gerenciador de pacotes como `dnf`, `apt-get` e inicia-lo como um serviço no Linux (SO que usaremos para todos os exemplos), ou podemos realizar o download do _.zip_ no site da [Elastic]( https://www.elastic.co/downloads/elasticsearch ) (nada impede de registrá-lo como um serviço no SO também, mas enfim...).

Para este exemplo, vamos utilizar a segunda opção:

__1°__ - Realizar o download do .zip mais atual.
__2°__ - Realizar o unzip do pacote baixado.
__3°__ - Pronto, Elasticsearch instalado. Fácil né ? Agora vamos ver se tudo ocorreu bem ?

Dentro do diretório gerado após a descompactação, vamos executar:
```
$ nohup bin/elasticsearch &
```

Dessa forma, o processo do Elasticsearch se iniciará em background. Após alguns segundos, execute o seguinte comando:

```
$ curl -XGET http://localhost:9200/
```
Se um retorno parecido com esse ocorreu, quer dizer que tudo está funcionando como deveria:
```

```

O que fizemos aqui ? Lembra que o Elasticsearch possui uma API RESTful ? Basicamente, fizemos uma chamada REST solicitando uma resposta para o nosso Elasticsearch através do método http __GET__ e como resposta à nossa requisição, recebemos
