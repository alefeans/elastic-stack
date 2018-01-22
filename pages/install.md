## Instalação

Instalar o Elasticsearch é a segunda coisa mais fácil do mundo de se fazer. A primeira é desinstalar. Vamos ver como se faz ?

Podemos fazer o download pelo repositório da Elastic atravéz de um gerenciador de pacotes como `dnf` ou `apt-get`, ou podemos realizar o download do .zip no site da [Elastic]( https://www.elastic.co/downloads/elasticsearch ). Para conseguir realizar todo o treinamento, não se esqueça de garantir pelo menos 3GB de memória para sua máquina, VM ou container, ok ?


Para este exemplo, vamos utilizar a segunda opção:

__1°__ - Realizar o download do .zip mais atual do Elasticsearch.

__2°__ - Realizar o unzip do pacote baixado em algum diretório do seu servidor.

__3°__ - Pronto, Elasticsearch instalado. Fácil né ? Agora vamos ver se tudo ocorreu bem ?

__OBS:__ Acredito que haja retrocompatibilidade na maioria das operações que iremos realizar, mas para este guia estamos utilizando especificamente a versão 5.6.5 de todas as ferramentas da stack.

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
