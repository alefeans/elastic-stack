## Monitorando Containers

Agora vamos falar de um assunto que já está em alta há alguns anos: __containers__. Mais especificamente sobre o __[Docker](https://www.docker.com/)__, que provavelmente (dando aquela amenizada na assertividade), é a solução de containers mais famosa e utilizada produtivamente nas organizações. Por isso, decidi criar esse tópico (que pode ser visto como um _extra_), para explicar como podemos criar uma monitoração para containers de uma forma bem simples e funcional utilizando o nosso Elastic Stack.

Falando de forma bem básica, o Docker é uma solução de containers que permite o isolamento da sua aplicação, junto com as suas dependências, em um ambiente de execução totalmente portável para qualquer plataforma que possua o Docker instalado. Para facilitar o entendimento, imagine o seguinte cenário: você tem uma aplicação feita em Ruby que depende de uma cacetada de bibliotecas instaladas no seu sistema operacional para poder ser executada. Seria bem chato compartilhar essa aplicação com o _mundo_ e garantir que ela vá funcionar sem nenhum problema para todos os usuários, certo ? O Docker te permite encapsular sua aplicação em um _container_ que possua _tudo_ que a sua aplicação precisa para executar. Sendo assim, quando você precisar compartilhar essa aplicação, você simplesmente compartilha a _imagem_ que contenha sua aplicação e qualquer pessoa que possua a _engine_ do Docker instalada, poderá utilizar o seu software sem nenhum problema. Isso _acaba_ com alguns problemas clássicos no mundo de TI sobre aplicações sendo executadas em ambientes computacionais _"idênticos"_, mas que acabam apresentando comportamentos distintos ou até mesmo incompatibilidades. Essa é uma das principais vantagens de se utilizar o Docker, mas [existem outras](https://www.docker.com/what-container) bem interessantes também.

O primeiro passo para iniciarmos a prática deste tópico, é instalar o Docker no seu host. Faça o download do pacote Community Edition do Docker para o seu sistema operacional seguindo os passos deste [link](https://www.docker.com/community-edition#/download).

Após ter o Docker instalado, faça a subida do processo e verifique a versão do mesmo:

```
sudo systemctl start docker
docker --version
Docker version 17.12.0-ce, build c97c6d6
```

Ótimo, agora vamos subir uma instância de Logstash utilizando um outro arquivo de configuração. Crie o arquivo _logstash-docker.conf_ no diretório /config da instalação do seu Logstash (como fizemos no passo [logstash](/pages/logstash.md)), com o seguinte conteúdo:

```
input {
  gelf {
    type => docker
    port => 12201
  }
}

output {
  stdout {}
  elasticsearch {
    hosts => ["http://localhost:9200"]
    index => "docker"
  }
}
```

A configuração acima receberá as logs do nosso container através do driver __[gelf](https://docs.docker.com/config/containers/logging/gelf/)__, que fará a leitura das logs do nosso container Docker. Estamos associando a porta __12201__, onde o Logstash receberá as entradas e enviará para o Elasticsearch, inserindo os dados no index "docker".

Faça a subida do Logstash:

```
nohup ./logstash -f ../config/logstash-docker.conf &
```

Agora, vamos fazer a subida de um container de Apache, utilizando o comando abaixo:

```
docker run -d -p 8080:80 --log-driver gelf --log-opt gelf-address=udp://localhost:12201 httpd
```

O comando acima, realiza o download (caso você não possua a imagem em seu host), de uma imagem com o nome __"httpd"__ do [Docker Hub](https://hub.docker.com/), que é o repositório oficial de imagens do Docker. Essa é a imagem oficial do Apache. Após o download, a imagem é executada. Vamos entender os parâmetros que passamos:

__-d__ - Executa o container em background.
__-p__ - Correlaciona a porta 8080 do seu host, com a porta 80 do container.
__--log-driver gelf__ - Informa qual será o driver de log utilizado pelo nosso container Docker.
__--log-opt gelf-address__ - Com este parâmetro, informarmos o protocolo e servidor "gelf" (nesse caso, o Logstash), que receberá as logs do container.
__httpd__ - Apenas o nome do container que será executado.

Verifique a instância em execução com o comando abaixo:

```
docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS                  NAMES
a893835da10e        httpd               "httpd-foreground"   34 minutes ago      Up 34 minutes       0.0.0.0:8080->80/tcp   clever_dijkstra
```

Teste o seu container de Apache acessando o endereço http://localhost:8080 no seu host. Se apareceu a mensagem "It Works", quer dizer que está tudo ok.

Agora vamos até o nosso Kibana, criar o nosso index "docker":

![](/gifs/docker.gif)

Pronto, agora estamos coletando todas as logs do nosso container ! Para fazer a leitura das logs de outros containers, é só utilizar os mesmos parâmetros que utilizamos na subida do container, que o comportamento será o mesmo.

Caso queira finalizar o seu container, utilize o comando `docker stop <CONTAINER ID>`.
