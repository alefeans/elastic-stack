#!/bin/bash
curl -XPOST http://localhost:9200/_bulk -d '

{ "create": { "_index": "twitter", "_type": "user", "_id": "1" }}
{ "email" : "tom@smith.com", "name" : "Tom Michael", "username" : "@tom" }
{ "create": { "_index": "twitter", "_type": "user", "_id": "2" }}
{ "email" : "lina@jones.com", "name" : "Lina Jones", "username" : "@lina" }
{ "create": { "_index": "twitter", "_type": "tweet", "_id": "3" }}
{ "date" : "2018-09-13", "name" : "Lina Jones", "tweet" : "Elasticsearch means full text search has never been so easy", "user_id" : 2 }
{ "create": { "_index": "twitter", "_type": "tweet", "_id": "4" }}
{ "date" : "2018-09-14", "name" : "Tom Michael", "tweet" : "@lina it is not just text, it does everything", "user_id" : 1 }
{ "create": { "_index": "twitter", "_type": "tweet", "_id": "5" }}
{ "date" : "2018-09-15", "name" : "Lina Jones", "tweet" : "However did I manage before Elasticsearch?", "user_id" : 2 }
{ "create": { "_index": "twitter", "_type": "tweet", "_id": "6" }}
{ "date" : "2018-09-16", "name" : "Tom Michael",  "tweet" : "The Elasticsearch API is really easy to use", "user_id" : 1 }
{ "create": { "_index": "twitter", "_type": "tweet", "_id": "7" }}
{ "date" : "2018-09-17", "name" : "Lina Jones", "tweet" : "The Query DSL is really powerful and flexible", "user_id" : 2 }
{ "create": { "_index": "twitter", "_type": "tweet", "_id": "8" }}
{ "date" : "2018-09-18", "name" : "Tom Michael", "user_id" : 1 }
{ "create": { "_index": "twitter", "_type": "tweet", "_id": "9" }}
{ "date" : "2018-09-19", "name" : "Lina Jones", "tweet" : "Geo-location aggregations are really cool", "user_id" : 2 }
{ "create": { "_index": "twitter", "_type": "tweet", "_id": "10" }}
{ "date" : "2018-09-20", "name" : "Tom Michael", "tweet" : "Elasticsearch surely is one of the hottest new NoSQL products", "user_id" : 1 }
{ "create": { "_index": "twitter", "_type": "tweet", "_id": "11" }}
{ "date" : "2018-09-21", "name" : "Lina Jones", "tweet" : "Elasticsearch is built for the cloud, easy to scale", "user_id" : 2 }
{ "create": { "_index": "twitter", "_type": "tweet", "_id": "12" }}
{ "date" : "2018-09-22", "name" : "Tom Michael", "tweet" : "Elasticsearch and I have left the honeymoon stage, and I still love her.", "user_id" : 1 }
{ "create": { "_index": "twitter", "_type": "tweet", "_id": "13" }}
{ "date" : "2018-09-23", "name" : "Tom Michael", "tweet" : "So yes, I am an Elasticsearch fanboy", "user_id" : 2 }
{ "create": { "_index": "twitter", "_type": "tweet", "_id": "14" }}
{ "date" : "2018-09-24", "name" : "Phill Matt", "tweet" : "Just one is sufficient.", "user_id" : 3 }
'
