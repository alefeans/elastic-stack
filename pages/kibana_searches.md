## Pesquisas no Kibana

Vamos executar algumas pesquisas para entendermos a Lucene Syntax e vermos como os tipos de pesquisas se comportam no Kibana.

### Full-Text

Lembra que eu havia dito que pesquisas full-text no Kibana se parecem com pequisas feitas no Google ? Faça o seguinte teste, vá até a aba "Discover" e utilize a barra de search para procurar pelo nome do seu host:

![](/images/kibana_fulltext.png)

Não está convencido ? Procure por "gif", "access_log" ou "curl":

![](/images/kibana_fulltext2.png)

Vejam que não passamos nenhum campo como parâmetro de busca e mesmo assim ele foi capaz de encontrar os documentos.

### Estruturada

Caso o nosso objetivo seja encontrar um valor em um campo específico, é só fazer da seguinte forma:

![](/images/kibana_structured.png)

Na pesquisa acima, estamos buscando o retorno "200" do Apache no campo "message", que significa a requisição foi atendida com sucesso.

E se quisermos adicionar uma condição em nossa pesquisa ? É só utilizarmos os [operadores condicionais](https://lucene.apache.org/core/2_9_4/queryparsersyntax.html) da Lucene Syntax. Na pesquisa abaixo, vamos pesquisar todas as respostas "200" em todos os hosts com o nome "fedora-host":

![](/images/kibana_conditional.png)

### Analítica

Resultados analíticos são melhor observados utilizando as views do Kibana, e a nossa primeira view realizada mais acima, foi exatamente uma pesquisa analítica. Sendo assim, vamos partir para a criação de nossos dashboards !


Próximo: [Criando Views](/pages/views.md)
