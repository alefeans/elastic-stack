## Elasticsearch

O `Elasticsearch` é uma ferramenta de buscas _open source_ desenvolvido em Java, assim como é uma solução NoSQL de armazenamento de dados. Ou seja, ele não segue os padrões de bancos de dados SQL comuns (como o MySQL, por exemplo).

Seu desenvolvimento tem como base uma biblioteca Java chamada [Apache Lucene](https://github.com/apache/lucene-solr), que é o motor de buscas open source mais avançado oferecido hoje em dia. Porém, usar todo o poder de fogo do Lucene exige um certo esforço, afinal por ser apenas uma biblioteca, você precisa trabalhar com o Java para integrá-lo com a sua aplicação (e esta tarefa pode apresentar uma certa complexidade).

O Elasticsearch no entanto, se aproveita do Lucene na _indexação_ e pesquisa de documentos, retirando a sua complexidade através de uma _API RESTful_ super fácil de se utilizar. Além disso, vamos citar algumas características que o tornam uma ferramenta excelente e extremamente veloz:

* Uma API RESTful para inclusão, remoção e acesso aos dados utilizando o padrão JSON.
* Totalmente livre de normalização.
* Qualquer palavra _indexada_ no Elasticsearch pode ser pesquisada da mesma forma que você faz uma busca no Google.
* Altamente escalável (feito para o _Cloud Computing_).
* Permite pesquisas estruturadas e analíticas em _"real time"_.
* Possui uma inteligência interna que entrega o melhor resultado em relação a busca feita (análise de relevância).
* Extremamente rápido. Explicaremos o por quê `:)`

## Onde usar ?

Tudo bem, ficou claro o que o Elasticsearch é. Mas aonde e como eu posso utilizá-lo ?

__Exemplo 1:__
Bem, um dos cenários mais comuns é utiliza-lo como um agregador de logs em conjunto com o Logstash e o Kibana, que são outras ferramentas da organização _Elastic_, formando o que chamamos atualmente de `Elastic Stack` (o acrônimo `ELK` não é mais utilizado). Através desta _stack_, possuímos uma ferramenta de busca e armazenamento de documentos (Elasticsearch), uma ferramenta de agregação, filtro e envio de dados (Logstash) e por fim, uma interface gráfica web para pesquisa e análise dos dados já armazenados (Kibana).

A partir disso, você sysadmin ou desenvolvedor, pode centralizar qualquer tipo de log gerado por _"qualquer coisa que gere log"_ e então, realizar análises, pesquisas de baseline ou montar dashboards de métricas pré-definidas.

Vamos imaginar a seguinte situação: você é responsável por um sistema computacional que possui 30 servidores e em cada um, 30 _microserviços_ diferentes. De repente, algum problema crítico acontece com este sistema e você precisa descobrir o que ocorreu. Por instinto, você irá ler as logs do sistema para tentar entender o que houve, certo ? Mas... será que você pode se dar ao luxo de logar em 30 servidores e procurar a log entre 30 microserviços diferentes em um momento de crise ?

Agora, se você possuir um ponto central que lhe permita realizar uma busca através de uma sintaxe super simples ou ainda que lhe permita gerar um gráfico que contabilize a quantidade de vezes que um certo erro ocorre, será muito mais fácil de identificar o problema não concorda ? Prazer, `Elastic Stack`.

__Exemplo 2:__
Outra forma de se usar o Elasticsearch é como uma solução NoSQL. Como ele escala horizontalmente com extrema facilidade (escalar horizontalmente nada mais é do que adicionar novos servidores com instâncias de Elasticsearch atuando como se fosse uma, representando o que chamamos de _cluster_), é comum ver empresas utilizando-o como um _Big Data_, já que a quantidade de dados e servidores gerenciados não é um problema para o Elasticsearch (_deal with it_). Neste caso de uso em específico, o Logstash pode não existir na composição da stack, mas o Kibana pode ainda ser utilizado para visualizar os dados graficamente.

Enfim, chega de conversa. Vamos ver como isso funciona na prática !

Próximo: [Instalação](/pages/install.md)
