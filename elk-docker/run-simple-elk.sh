#!/bin/bash

docker rm -f logstash
docker rm -f kibana
docker rm -f elasticsearch

docker run --name elasticsearch \
  -d --restart=unless-stopped \
  -p 9200:9200 -p 9300:9300 \
  -e "discovery.type=single-node" \
  docker.elastic.co/elasticsearch/elasticsearch:7.10.1

docker run --name kibana \
  -d --restart=unless-stopped \
  --link elasticsearch:elasticsearch \
  -p 5601:5601 \
  docker.elastic.co/kibana/kibana:7.10.1

docker run --name logstash \
  -d --restart=unless-stopped \
  --link elasticsearch:elasticsearch \
  -p 9600:9600 \
  docker.elastic.co/logstash/logstash:7.10.1 
