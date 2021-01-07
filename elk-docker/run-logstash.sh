docker run --name logstash \
  -d --restart=unless-stopped \
  --link elasticsearch:elasticsearch \
  -p 9600:9600 \
  docker.elastic.co/logstash/logstash:7.10.1
