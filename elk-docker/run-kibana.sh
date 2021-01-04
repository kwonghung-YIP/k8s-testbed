docker run -d --name kibana \
  --link YOUR_ELASTICSEARCH_CONTAINER_NAME_OR_ID:elasticsearch \
  -p 5601:5601 \
  docker.elastic.co/kibana/kibana:7.10.1
