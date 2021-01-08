#!/bin/bash

docker rm -f filebeat
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
  --volume="$(pwd)/logstash.yml:/usr/share/logstash/config/logstash.yml:ro" \
  -p 9600:9600 -p 5044:5044\
  docker.elastic.co/logstash/logstash:7.10.1 

docker run --name=filebeat \
  -d --restart=unless-stopped \
  --user=root \
  --volume="$(pwd)/filebeat.yml:/usr/share/filebeat/filebeat.yml:ro" \
  --volume="/var/lib/docker/containers:/var/lib/docker/containers:ro" \
  --volume="/var/run/docker.sock:/var/run/docker.sock:ro" \
  --link logstash:logstash \
  docker.elastic.co/beats/filebeat:7.10.1 \
  filebeat -e -strict.perms=false
