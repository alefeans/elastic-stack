#!/bin/bash

for i in $(seq 50); do	
    curl -i -o /dev/null localhost/icons/apache_pb2.gif
    sleep 1
    for x in $(( ( RANDOM % 10 ) + 1 )); do
        curl -s localhost:80/bla > /dev/null
    done;
    for y in $(( ( RANDOM % 10 ) + 1 )); do
	sleep 1
    curl -i -o /dev/null localhost/icons/apache_pb2.gif
    done;
done;

