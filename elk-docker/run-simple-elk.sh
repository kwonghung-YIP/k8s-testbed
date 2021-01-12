#!/bin/bash

docker rm -f filebeat
docker rm -f logstash
docker rm -f kibana
docker rm -f elasticsearch

docker rm -f springboot-webapp
docker rm -f nginx

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
  --volume="$(pwd)/logstash.conf:/usr/share/logstash/pipeline/logstash.conf:ro" \
  -p 9600:9600 -p 5044:5044 \
  docker.elastic.co/logstash/logstash:7.10.1

docker run --name filebeat \
  -d --restart=unless-stopped \
  --user=root \
  --volume="$(pwd)/filebeat.yml:/usr/share/filebeat/filebeat.yml:ro" \
  --volume="/var/lib/docker/containers:/var/lib/docker/containers:ro" \
  --volume="/var/run/docker.sock:/var/run/docker.sock:ro" \
  --link logstash:logstash \
  docker.elastic.co/beats/filebeat:7.10.1 \
  filebeat -e -strict.perms=false

docker run --name springboot-webapp \
  -d --restart=always \
  -p 8080:8080 -p 8090:8090 \
  --label co.elastic.logs/enabled=true \
  --label co.elastic.logs/multiline.pattern="^[0-9]{4}-[0-9]{2}-[0-9]{2}" \
  --label co.elastic.logs/multiline.negate="true" \
  --label co.elastic.logs/multiline.match="after" \
  kwonghung/springboot-to-skaffold:latest

docker run --name nginx \
  -d --restart=always \
  -p 9080:80 -p 9443:443 \
  --label co.elastic.logs/enabled=true \
  --label co.elastic.logs/module=nginx \
  nginx:1.18-alpine
