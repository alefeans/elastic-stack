## Avançando na Stack

Estamos há um bom tempo falando somente sobre o Elasticsearch e há um motivo especial para isso. Ele é o coração da nossa stack. É essencial compreender bem o seu funcionamento para não haver nenhuma dúvida na hora de procurarmos nossos documentos ou quando começarmos a criar nossos dashboards no Kibana.

## Instalação - Logstash e Kibana

Agora, chega de enrolação ! Vamos realizar a instalação da mesma forma que instalamos o Elasticsearch, realizando o download do _.zip_ do [Kibana](https://www.elastic.co/downloads/kibana) e do [Logstash](https://www.elastic.co/downloads/logstash), realizando o unzip em um diretório separado para cada um deles e pronto, fácil né ? Elastic né filho...

__OBS:__ Pode ser que não haja nenhum problema de compatibilidade, mas lembre-se que estamos utilizando a versão 5.6.5 para todas as ferramentas da stack neste repositório. Não se esqueça também de validar a quantidade de memória disponível do seu host para a subida do Kibana.

Agora, entre no diretório da instalação do Kibana e navegue até o diretório _bin_. Execute o comando abaixo para subir uma instância:

```
nohup ./kibana &
```

Após a subida do processo, acesse o endereço http://localhost:5601 no seu browser.

__OBS:__ Caso esteja utilizando uma máquina virtual, utilizar o endereço de IP da sua vm ao invés de _localhost_.
