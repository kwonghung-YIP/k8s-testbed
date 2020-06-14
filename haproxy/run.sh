docker run \
  --name haproxy -it --rm \
  --network host \
  --user haproxy:haproxy \
  -v $PWD/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg \
  haproxy:2.1

docker run \
  --name haproxy -d --restart always \
  --network host \
  -v $PWD/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg \
  -v $PWD/istio-gateway.pem:/usr/local/etc/haproxy/certs/istio-gateway.pem \
  haproxy:2.1
