## Instalação

Instalar o Elasticsearch é a segunda coisa mais fácil do mundo de se fazer. A primeira é desinstalar... vamos ver como se faz?

Podemos fazer o download pelo repositório da Elastic através de um gerenciador de pacotes como `dnf` ou `apt-get`, ou podemos realizar o download do .zip no site da [Elastic]( https://www.elastic.co/downloads/elasticsearch ). Para conseguir realizar todo o treinamento, não se esqueça de garantir pelo menos 4GB de memória livre no seu host, ok?

Para este exemplo, vamos utilizar a segunda opção:

__1°__ - Realizar o download do .zip mais atual do Elasticsearch.

__2°__ - Realizar o unzip do pacote baixado em algum diretório do seu servidor.

__3°__ - Pronto, Elasticsearch instalado. Fácil né? Agora vamos ver se tudo ocorreu bem?

__OBS:__ Acredito que não teremos problemas de compatibilidade na maioria das operações que iremos realizar, mas para este guia estamos utilizando especificamente a versão __5.6.5__ de todas as ferramentas da stack.

__OBS²:__ Como pré-requisito para utilizarmos o Elasticsearch, precisamos ter o Java 1.8 instalado em nosso host. Confira como realizar a instalação do pacote para o seu sistema operacional através deste __[ link](https://docs.oracle.com/javase/8/docs/technotes/guides/install/install_overview.html)__.

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
  "name" : "XJWzjDi",                         # Nome da sua instância de Elasticsearch (personalizável).
  "cluster_name" : "elasticsearch",           # Nome do cluster que a nossa instância pertence (personalizável).
  "cluster_uuid" : "ZH9GequzQX-oobJVGPlbjg",  # Identificador universal do seu cluster (como um CPF do seu cluster).
  "version" : {                               # Dentro desta "tag" temos todas as informações sobre versão de produto.
  "number" : "5.6.5",                         # Versão do Elasticsearch.
  "build_hash" : "57e20f3",                   # "ID" da geração deste pacote de Elasticsearch.
  "build_date" : "2017-09-23T13:16:45.703Z",  # Data de geração deste pacote.
  "build_snapshot" : false,                   # Irrelevante (é irrelevante sim, para de reclamar).
  "lucene_version" : "6.6.1"                  # Versão do Lucene utilizada.
},
  "tagline" : "You Know, for Search"          # Uma resposta amigável do Elasticsearch.
}
```

Próximo: [REST e JSON](/pages/rest_json.md)
