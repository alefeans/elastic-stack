## REST e JSON

Legal, mas o que realmente aconteceu aqui ? Lembra que o Elasticsearch possui uma API RESTful ? Lembra o que é API RESTful ? Lembra o que é REST ? Não ? Que vergonha...

Falando da forma mais simples possível, uma API RESTful é uma API que faz/aceita chamadas REST e REST, representa um conjunto de operações padronizadas que permitem a troca de informação entre sistemas através de simples métodos HTTP.

No exemplo anterior, fizemos uma chamada __REST__ solicitando uma resposta para o nosso Elasticsearch através do método HTTP __GET__ e como retorno à nossa requisição, recebemos uma resposta no formato __JSON__ com algumas informações básicas sobre a nossa instância de Elasticsearch.

Sempre usaremos o formato JSON ao trabalharmos com o Elasticsearch, tanto para enviar requisições, quanto no recebimento das respostas.

Sobre o JSON, imagine que você precisa fazer duas aplicações totalmente distintas se comunicarem entre si. Como fazer essa troca de informação ? O JSON por ser um formato padrão aceito pela maioria das linguagens de programação, pode ser utilizado para garantir que as duas aplicações possam "entender" o que a outra está querendo dizer de forma mais simples e legível se comparada com outros padrões (como o _XML_, por exemplo). Vamos ver como este padrão funciona ?

```
{                           # Abertura de sequência.
                            # O padrão é: "campo" ":" e "valor".
                            # Caso hajam vários campos, colocar uma "," no final.
  "nome": "John Will",      # Strings precisam estar entre aspas.
  "idade": 19,              # Inteiros são apresentados sem aspas.
  "deficiente": True,       # Booleanos são bem-vindos.
  "interesses": [ "musica", # Arrays sao representados entre "[]".
            "esportes"]
}                           # Fechamento da sequência. Fim do documento JSON.
```

Agora que sabemos como criar um _documento_ JSON, vamos entender a sintaxe utilizada para as chamadas REST:

```
curl -X<VERB> '<PROTOCOLO>://<HOST>:<PORTA>/<PATH>?<QUERY_STRING>' -d '<BODY>'
```

O __curl__ é uma ferramenta para transferência de dados através de uma URL. Usaremos ela para efetuarmos nossas requisições ao Elasticsearch. Segue a explicação para os demais campos:

__VERB__ -> GET, POST, PUT, DELETE.

__PROTOCOLO__ -> http, https...

__HOST__ -> Servidor do Elasticsearch.

__PORTA__ -> Porta do Elasticsearch (9200 é a porta padrão).

__PATH__ -> Aonde você quer pesquisar, atualizar, incluir ou deletar (qual o _index_, _type_ e _document id_ ?).

__QUERY_STRING__ -> A pesquisa propriamente dita.

__BODY__ -> O documento JSON que você quer enviar ou utilizar como parâmetro de pesquisa.

Próximo: [Index, Type e Document ?](/pages/index_type_document.md)
