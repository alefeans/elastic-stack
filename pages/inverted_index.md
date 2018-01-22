## Inverted Index

Nosso último ponto, antes de partirmos para as outras ferramentas da stack, será totalmente teórico e irá abordar sobre _uma das_ funcionalidades que tornam o Elasticsearch extremamente rápido na hora de fazer suas pesquisas, o __inveterd index__.

O inverted index ou índice invertido (_high level fluent traduction_), é uma estrutura que consiste em uma lista de todas as únicas palavras que aparecem em qualquer documento, e para cada palavra, uma lista de documentos em que ela aparece. Para facilitar o entendimento, vamos supor que possuímos dois documentos, cada um com um campo chamado __"informacao"__, contendo os seguintes valores:

__1°__ - O bulldog frances gosta de pular na grama
__2°__ - Bulldog frances saltou na grama com gosto

Um índice invertido destes documentos, seriam criados da seguinte forma. Primeiro, o conteúdo do campo _informacao_ é dividido em palavras separadas (o que o Elasticsearch denomina de __"terms"__ ou __"tokens"__). Depois, criamos uma lista  de todos os "termos" únicos e então, listamos em quais documentos cada termo aparece. O resultado se parece como a tabela abaixo:

| Termo   | Documento_1 | Documento_2 |
| ------- |-----------|-------------|
|Bulldog  |           |    __X__    |
|O        |     __X__ |             |
|bulldog  |     __X__ |             |
|de       |     __X__ |             |
|frances  |     __X__ |    __X__    |
|na       |     __X__ |    __X__    |
|pular    |     __X__ |             |
|saltou   |           |   __X__     |
|gosto    |           |   __X__     |
|grama    |     __X__ |   __X__     |
|gosta    |     __X__ |             |
|com      |           |   __X__     |

Se quisermos fazer uma pesquisa para encontrar "bulldog frances", precisamos apenas encontrar os documentos que cada termo aparece:

| Termo   | Documento_1 | Documento_2 |
| ------- |-----------|-------------|
|bulldog  |     __X__ |             |
|frances  |     __X__ |    __X__    |
|TOTAL    |     __1__ |    __2__    |

Os dois documentos coincidem com a pesquisa, porém o primeiro documento possui mais proximidade com a busca. Ou seja, o primeiro documento é mais __relevante__ para a nossa pesquisa. Porém, existem alguns problemas com o nosso índice invertido:

__1°__ - "Bulldog" e "bulldog" aparecem como termos separados, enquanto para nós usuários, eles deveriam aparecer como a mesma palavra.

__2°__ - "pular" e "saltou", por mais que não sejam a mesma palavra, são sinônimos, ou seja, possuem o significado similar, independente do tempo verbal.

Seja por qualquer motivo, nosso usuário pode experar os documentos como resultado da busca. Portanto, se normalizarmos os termos em um formato padronizado, podemos apresentar documentos que contenham termos que não são exatamente o mesmo que o usuário requisitou, mas que são similares o suficiente para continuar relevante. Por exemplo:

__1°__ - "Bulldog" e "O" podem ser colocados em minúsculo.

__2°__ - "pular" e "saltou", podem ser indexados como apenas "pular".

Agora o nosso índice ficou assim:

| Termo   | Documento_1 | Documento_2 |
| ------- |-----------|-------------|
|o        |     __X__ |             |
|bulldog  |     __X__ |    __X__    |
|de       |     __X__ |             |
|frances  |     __X__ |    __X__    |
|na       |     __X__ |    __X__    |
|pular    |     __X__ |    __X__    |
|gosto    |           |    __X__    |
|grama    |     __X__ |    __X__    |
|gosta    |     __X__ |             |
|com      |           |    __X__    |

Agora nossos documentos estão mais "encontráveis", certo ? Esse processo de normalização é chamado de __"analysis"__ pelo Elasticsearch e é utilizado para facilitar a busca de documentos que possam indicar o mesmo significado, independente se o conteúdo não for exatamente o buscado.

O Elasticsearch fornece diversos "analisadores" que você pode utilizar na padronização de seus documentos. Como este tópico é apenas explicativo, não iremos realizar nenhuma alteração em nossos dados. De qualquer forma, saiba que este é um ponto muito importante e que deve ser avaliado com atenção em um ambiente real. Para mais informações, segue o bom e velho link da documentação da [Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-analyzers.html).
