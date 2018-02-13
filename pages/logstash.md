## Logstash

O Logstash tem a função básica de receber dados de diferentes fontes, fazer a transformação desses dados (ou não) e então, realizar a inserção no Elasticsearch. As fontes de dados podem ser inputs manuais, logs de sistema operacional (como o "/var/log/messages"), logs de aplicação ou qualquer "outra coisa" que possa ser lida.

Como fonte de dados, vamos utilizar o Web Server mais famoso do mundo, o _Apache HTTP server_. Faça a instalação do Apache utilizando o gerenciador de pacotes da sua distribuição Linux:

```
sudo dnf install httpd
```

Após realizar a instalação, faça a subida do processo:

```
systemctl start httpd
```

__OBS:__ Em algumas distribuições o Apache já vem instalado por default, em outras o nome do pacote pode ser diferente. Isto pode alterar a forma de instalação e de subida do processo. Na dúvida, dê uma pesquisada rápida no Google que você encontrará a resposta :)

Para testar se está tudo ok com o seu Apache, acesse o endereço "http://localhost:80" no seu browser. Se aparecer a página do Apache, significa que tudo deu certo com a sua instalação.

Em distribuições baseadas em Red Hat, as logs do Apache são armazenadas no diretório "/var/log/httpd". Sendo assim, vamos criar o arquivo de configuração do Logstash para ler as logs deste diretório. Caso você esteja utilizando uma distribuiçao diferente, as logs podem estar em outro caminho (possivelmente em "/var/log/apache2", mas dá uma olhada ai que você acha fácil) . No diretório de instalação do Logstash, vá até o caminho "/config", crie o arquivo _"logstash-apache.conf"_ e cole o conteúdo abaixo:

```
input {
  file {
    path => "/var/log/httpd/*_log"
    start_position => "beginning"
  }
}

output {
  elasticsearch {
    hosts => ["localhost:9200"]
    index => "apache"
  }
  stdout {}
}
```

Os arquivos de configuração do Logstash possuem 3 seções:

__input:__ Aqui, configuramos todas as entradas dos dados. Estamos utilizando o plugin __"file"__, que é utilizado para a leitura de arquivos (_really ?_). Existem diversos plugins configuráveis como "http", "github", "jdbc" e etc (caso queira ver a listagem completa acesse o link: [input_plugins](https://www.elastic.co/guide/en/logstash/current/input-plugins.html)). Dentro da configuração do plugin "file", estamos informando o diretório onde o Logstash fará a leitura dos arquivos (a expressão "\*_log" significa que todos os arquivos que terminem com "_log" serão lidos), e também em que posição ele iniciará leitura dos arquivos. Como estamos utilizando a opção "beginning", o Logstash captura todo o conteúdo do arquivo desde a primeira linha. Caso utilizassemos a opção "end", ele começaria a leitura após o final do arquivo, ou seja, só leria as novas informações que serão incrementadas no arquivo, ignorando o conteúdo anterior. De qualquer forma, estas duas opções só modificam o primeiro contato do Logstash com os arquivos.

__filter:__ Não estamos utilizando esta opção no nosso arquivo de configuração, mas nesta diretiva podemos configurar [diversos filtros](https://www.elastic.co/guide/en/logstash/current/filter-plugins.html) para realizar a transformação dos dados antes de serem indexados no Elasticsearch.

__output:__ Nesta opção, configuramos o destino dos nossos dados. Estamos utilizando o [plugin de saída](https://www.elastic.co/guide/en/logstash/current/output-plugins.html) para o endereço do nosso Elasticsearch, informando o index "apache" que será utilizado para o armazenamento das nossas logs. Também estamos utilizando o plugin "stdout" para direcionarmos a saída do processo do Logstash quando o executamos. Ao subirmos o processo, iremos direcionar esta saída para o arquivo "nohup.out". É apenas uma forma de mapear o que nosso processo está _fazendo_ em forma de log.

__Atenção !__ Vai rolar uma gambiarra agora... mas não se preocupe, é apenas para facilitar a sua vida. Como as logs do Apache são geradas em um caminho onde os usuários comuns não tem acesso, vamos precisar alterar o _owner_ da instalação do seu Logstash para o "root". Caso contrário, teríamos que fazer algumas alterações no Apache ou/e em outras coisinhas chatas que só atrasariam o foco do nosso aprendizado e bla bla bla. Sendo assim, altera ai vai... tem ninguém olhando não:

```
$ ls -ltr
drwxr-xr-x. 12 alefeans alefeans 4096 dez  4 05:57 kibana-5.6.5-linux-x86_64
drwxr-xr-x.  9 alefeans alefeans 4096 jan  9 13:47 elasticsearch-5.6.5
drwxr-xr-x. 12 alefeans alefeans 4096 jan 16 12:40 logstash-5.6.5

$ sudo chown -R root:root logstash-5.6.5/
$ ls -ltr
drwxr-xr-x. 12 alefeans alefeans 4096 dez  4 05:57 kibana-5.6.5-linux-x86_64
drwxr-xr-x.  9 alefeans alefeans 4096 jan  9 13:47 elasticsearch-5.6.5
drwxr-xr-x. 12 root     root     4096 jan 16 12:40 logstash-5.6.5

```

Agora, vá até o diretório "/bin" da instalação do Logstash e execute o comando abaixo para iniciá-lo. Não se esqueça de executá-lo com o usuário __"root"__:

```
nohup ./logstash -f ../config/logstash-apache.conf &
```

Utilizamos o parâmetro "-f" para informar ao Logstash o arquivo de configuração que criamos. Feito isso, vamos validar o nosso index "apache" no Kibana:

![](/gifs/apache_index.gif)

Agora conseguimos visualizar todas as requisições feitas ao nosso servidor Web pelo Kibana ! Caso você não esteja visualizando nenhum dado, certifique-se de alterar o filtro de tempo no canto superior direito, ajustando com a data em que a entrada dos dados foi feita. É interessante também configurar um refresh automático para visualizar a entrada dos dados em real-time.

Faça algumas requisições ao seu Apache acessando o endereço http://localhost:80 e http://localhost:80/bla (para forçarmos um erro em nossas logs) ou simplesmente execute o script [requests.sh](/scripts/requests.sh), para gerarmos uma massa de dados em nosso index:

```
nohup ./requests.sh &
```

__OBS:__ O script está apontando para o endereço __localhost__, então caso esteja utilizando mais de um servidor para as atividades deste repositório, certifique-se de executá-lo no servidor onde o seu Apache está executando.

__OBS²:__ Executamos o script em background, pois o mesmo demora um pouquinho para finalizar sua execução. Caso queira aumentar a massa de dados, é só repetir a sua execução.

Próximo: [Pesquisas no Kibana](/pages/kibana_searches.md)
