## Node e Cluster

Lembra que eu havia dito que o Elasticsearch foi feito para o _Cloud Computing_ ? Nos próximos tópicos, explicarei como a redundância e a alta disponibilidade são tratadas internamente pela ferramenta através de alguns conceitos de _clusterização_ e replicação de dados. Esses conceitos são essenciais para entendermos a ferramenta mais a fundo e para comprovarmos a sua fácil adequação à um ambiente em nuvem.

Um __node__ é uma instância em execução de Elasticsearch, enquanto um __cluster__ consiste em um ou mais nodes trabalhando em conjunto, como se fossem uma só instância. Instâncias em um mesmo cluster compartilham do mesmo _cluster name_ e possuem uma organização que permite que mais instâncias sejam adicionadas ou removidas ao cluster sem prejudicar o armazenamento dos dados. Afinal, em um ambiente em _cloud_, é comum servidores serem adicionados ou descartados a todo momento e isso de forma alguma pode impactar a disponibilidade do serviço ou a integridade dos dados.

Em um cluster de Elasticsearch, sempre teremos uma instância declarada como node _master_, o que signficia que esta instância é responsável por lidar com alterações abrangentes que venham a modificar informações à nível de cluster (ex: criação/remoção de um index, adição de nodes ao cluster e etc). Pequenas alterações à nível de documento não exigem a participação do node master, sendo assim, ter apenas um node master em seu cluster _pode ser_ o suficiente. O interessante é que nós usuários podemos interagir com __qualquer__ node do cluster de forma transparente para realizarmos as operações comuns (inclusão, pesquisa, remoção e etc).

No nosso caso, temos apenas uma instância de Elasticsearch em execução, o que significa que nosso cluster possui apenas um node e que, obviamente, é o node master. Vamos utilizar abaixo a API **_cluster** para verificarmos a saúde do nosso ambiente:

```
curl -XGET http://localhost:9200/_cluster/health?pretty
```

O campo status utiliza de cores básicas para indicar a saúde do nosso cluster:

__Green__: Todos os shards primários e replicas estão ativos.  

__Yellow__: Todos os shards primários estão ativos, mas nem todas as réplicas estão.

__Red__: Nem todos os shards estão ativos.

Você deve estar pensando "E o que isso signficia se eu nem sei o que é um shard ?". Vamos tentar entender isto melhor agora...

Próximo: [Shards e Replicas](/pages/shards_replicas.md)
