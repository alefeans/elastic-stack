# Elastic Stack para iniciantes
   
   O objetivo desse repositório é apresentar o `Elastic Stack` de uma forma simples e amigável para quem está iniciando no assunto.
   
   Quando comecei a estudar sobre o Elastic Stack, encontrei diversos conteúdos que traziam explicações muito "pesadas" e que em alguns segundos, te faziam abrir várias janelas do browser para pesquisar o significado de cada sub-tópico, conceito ou ferramenta adjacente.
   
   Sendo assim, decidi criar este repositório com uma linguagem mais informal e direta para explicar a _stack_, sem deixar de apresentar os conceitos essenciais. Não se preocupe se em alguns momentos aparecerem termos confusos ainda não explicados, pois ao longo do treinamento eles se tornarão claros para você :)
   
   Inicialmente, vamos conceituar o que cada ferramenta é e o seu propósito.

## Elasticsearch


  O `elasticsearch` é uma ferramenta de buscas _open source_ desenvolvido em Java, assim como é uma solução NoSQL, ou seja, não segue os padrões de bancos de dados SQL comuns (como o MySQL, por exemplo). Ele tem como base o [Apache Lucene](https://github.com/apache/lucene-solr), que é uma biblioteca Java de pesquisa _full text_ e que é também, o motor de busca open source mais avançado oferecido hoje em dia. 
  
  Porém, Lucene é apenas uma library. Para usar o seu poder de fogo, você precisa trabalhar com o Java para integrar o Lucene com a sua aplicação. 
  
  O Elasticsearch no entanto, se aproveita do Lucene na _indexação_ e pesquisa de documentos, retirando a sua complexidade através de uma API RESTful super fácil de se utilizar. Além disso, vamos citar algumas características que o tornam uma ferramenta excelente e extremamente veloz:
  
* Uma API RESTful para inclusão, remoção e acesso aos dados utilizando o padrão JSON.
* Totalmente livre de normalização.
* Qualquer palavra _indexada_ no elasticsearch pode ser pesquisada da mesma forma como você faz uma busca no Google.
* Altamente escalável (feito para o _Cloud Computing_).
* Permite pesquisas estruturadas e analíticas em _real-time_.
* Possui uma inteligência interna que entrega o melhor resultado em relação a busca feita (análise de relevância).
* Extremamente rápido. Explicaremos o por quê `:)` 

## Onde usar ?

  Tudo bem, ficou claro o que o Elasticsearch é. Mas aonde e como eu posso utilizá-lo ? 
  
__Exemplo 1:__
Bem, um dos cenários mais comuns é utiliza-lo como um agregador de logs em conjunto com o Logstash e o Kibana, que são outras ferramentas da organização _Elastic_, formando o que chamamos atualmente de `Elastic Stack` (o acrônimo `ELK` não é mais utilizado). Através desta _stack_ de ferramentas, possuímos uma ferramenta de busca e armazenamento de documentos (Elasticsearch), uma ferramenta de agregação, filtro e envio de dados (Logstash) e por fim, uma _web view_ para pesquisa e análise gráfica dos dados já armazenados (o nosso querido Kibana).

A partir disso, você sysadmin ou desenvolvedor, pode centralizar qualquer tipo de log gerado por _"qualquer coisa que gere log"_ e então, realizar análises, pesquisas de baseline ou montar dashboards de métricas pré-definidas. 

Vamos imaginar a seguinte situação: você é responsável por um sistema computacional, que possui 30 servidores e em cada um, 30 _microserviços_ diferentes. De repente, algum problema crítico acontece com este sistema e você precisa descobrir o que ocorreu. Por instinto, você irá ler as logs do sistema para tentar entender o que houve, certo ? Mas... será que você pode se dar ao luxo de logar em 30 servidores e procurar a log entre 30 microserviços diferentes ? Agora, se você possuir um ponto central que lhe permita realizar uma busca através de uma sintaxe super simples ou ainda que lhe permita gerar um gráfico que contabilize a quantidade de vezes que esse erro ocorre, será muito mais fácil de identificar o problema não concorda ? Prazer, `Elastic Stack`.

__Exemplo 2:__
Outra forma de se usar o Elasticsearch é como uma solução NoSQL. Como ele escala horizontalmente com extrema facilidade (escalar horizontalmente nada mais é do que adicionar novos servidores com instâncias de Elasticsearch, atuando como se fosse uma (_cluster_)), é comum ver empresas utilizando-o como um _Big Data_, já que a quantidade de dados e servidores gerenciados, não é um problema para o Elasticsearch (_deal with it_).

Enfim, chega de conversa. Vamos ver como isso funciona na prática !

## Instalação

Instalar o Elasticsearch é a segunda coisa mais fácil do mundo de se fazer. A primeira é desinstalar. Vamos ver como se faz ?

Podemos fazer o download pelo repositório da Elastic atravéz de um gerenciador de pacotes como `dnf` ou `apt-get` e inicia-lo como um serviço no Linux (SO que usaremos para todos os exemplos neste repositório), ou podemos realizar o download do .zip no site da [Elastic]( https://www.elastic.co/downloads/elasticsearch ) (nada impede de registrá-lo como um serviço no SO também, mas enfim...). Não se esqueça de garantir pelo menos 3GB de memória para sua máquina, VM ou container ok ?


Para este exemplo, vamos utilizar a segunda opção:

__1°__ - Realizar o download do .zip mais atual.
__2°__ - Realizar o unzip do pacote baixado.
__3°__ - Pronto, Elasticsearch instalado. Fácil né ? Agora vamos ver se tudo ocorreu bem ?

Dentro do diretório gerado após a descompactação, vamos executar:
```
$ nohup bin/elasticsearch &
```

Dessa forma, o processo do Elasticsearch se iniciará em background. Após alguns segundos (ou se você acompanhou o start pelo nohup.out), execute o seguinte comando:

```
$ curl -XGET http://localhost:9200/
```
Se um retorno parecido com esse ocorreu, quer dizer que tudo está funcionando como deveria:
```
{
  "name" : "XJWzjDi",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "ZH9GequzQX-oobJVGPlbjg",
  "version" : {
    "number" : "5.6.2",
    "build_hash" : "57e20f3",
    "build_date" : "2017-09-23T13:16:45.703Z",
    "build_snapshot" : false,
    "lucene_version" : "6.6.1"
  },
  "tagline" : "You Know, for Search"
}

```
Legal, mas o que realmente aconteceu aqui ? Lembra que o Elasticsearch possui uma API RESTful ? Basicamente, fizemos uma chamada REST solicitando uma resposta para o nosso Elasticsearch através do método http __GET__ e como resposta à nossa requisição, recebemos uma resposta no formato JSON com algumas informações sobre a nossa instância de Elasticsearch. Vamos ver o que cada uma quer dizer:
