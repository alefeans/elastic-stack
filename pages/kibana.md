## Kibana

Se tudo deu certo, você deve estar visualizando a tela inicial do Kibana com algumas informações sobre o seu cluster de Elasticsearch. Atualize esta página e provavelmente você será direcionado para a seção "Management" do Kibana. Nesta seção, escolhemos quais índices iremos buscar em nosso Elasticsearch para a visualização no Kibana. Mude no campo "index pattern" o valor "logstash-\*" para "mycompany". Após isto, crie em "create":

![](/images/kibana_first.png)

Após isto, você será direcionado para uma página onde todos os campos do seu index poderam ser visualizados. Nesta página é possível alterar algumas coisinhas em seus campos, como tipo de dado e etc. Não vamos mexer em nada nesta tela, ok ? Ao invés disso, vamos entender as opções apresentadas no menu lateral esquerdo:

__Discover -__  Nesta aba, podemos ver graficamente os dados armazenados no Elasticsearch. Podemos nesta página, utilizar filtros e pesquisar nossos dados através de _Lucene Syntax_, que é uma sintáxe de busca super simples (vocês vão ver).

__Visualize -__ Permite a criação de visualizações customizadas, utilizando de diversos modelos "já prontos" para sua utilização.

__Dashboard -__ Nesta página, conseguimos agregar as views criadas na aba “Visualize” em um só dashboard.

__Timelion -__ Permite gerar gráficos de diferentes índices em diferentes períodos de tempo, através de expressões regulares. É um pouco complexo de se utilizar, porém oferece um grande poder de busca e comparação.

__Dev Tools -__ Possibilita realizar as pesquisas através de chamadas REST, como estavamos fazendo via linha de comando.

__Management-__ Gerenciamento dos índices e configurações avançadas do Kibana.

Agora, vamos acessar no menu lateral esquerdo, a aba "Discover". E olha ! Todos os dados do nosso index "mycompany" estão aqui:

![](/images/kibana_second.png)

Na imagem acima, perceba que fiz a expansão do documento da "Maria Costa", visualizando uma tabela com todos os campos e valores deste documento. Embaixo do nome do nosso index, podemos ver os campos disponíveis para realizarmos alguns filtros visuais. Veja na imagem abaixo que utilizei o filtro de "nome" e "interesses" para facilitar a visualização dos dados:

![](/images/kibana_third.png)

Temos pouquíssimos dados para criar um dashboard bonito e apresentá-lo ao chefe ou para fazermos um belo quadro (que é o objetivo real desse treinamento). Mas enquanto estamos nesta situação, vamos criar uma visualização simples para apurarmos nossas habilidades estatísticas para o nosso __dashboard final__ (*música de tensão*). Siga as instruções abaixo para a criação da nossa primeira _view_:

![](/gifs/first_visualization.gif)

Mexer no Kibana é muito simples e o gif é auto-explicativo... mas vamos mastigar um pouco mais o que foi feito. Escolhemos a opção default "Count" na primeira _"Aggregation"_, que irá fazer a contagem das vezes que um item é encontrado. Em nossos "buckets", fizemos a agregação (high translation capability), pelo termo "interesses". As "custom labels" são opcionais e só servem para facilitar a leitura dos campos nos gráficos. No final, tivemos um gráfico em formato de pizza, com as fatias separadas pelos interesses dos nossos funcionários, de acordo com a porcentagem de valores encontrados. Se parece com a busca __analítica__ que fizemos mais acima no Elasticsearch não é verdade ? Pois é exatamente a mesma operação. Viu como é muito mais simples quando utilizamos o Kibana ?

Para explorarmos o _Lucene Query Syntax_ e gerarmos gráficos mais interessantes, precisamos de uma massa de dados maior do que a que possuímos. Sendo assim, vamos gerar esta massa !
