#!/bin/bash
curl -XPUT http://localhost:9200/mycompany/funcionarios/2 -d '
{
  "nome": "Maria Costa",
  "idade": 34,
  "endereco": "Rua da Frente",
  "hobbies": ["Ouvir musica", "Andar de bicicleta"],
  "interesses": ["esportes", "musica"]
}'

curl -XPUT http://localhost:9200/mycompany/funcionarios/3 -d '
{
  "nome": "José Cardoso",
  "idade": 28,
  "endereco": "Rua de Trás",
  "hobbies": "Ir para a academia",
  "interesses": ["esportes", "musculacao"]
}'


curl -XPUT http://localhost:9200/mycompany/funcionarios/4 -d '
{
  "nome": "Claudio Silva",
  "idade": 31,
  "endereco": "Avenida do Meio",
  "hobbies": ["Jogar PS4", "Programar"],
  "interesses": ["filmes", "games"]
}'
