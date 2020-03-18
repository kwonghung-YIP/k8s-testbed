docker run \
  --name haproxy -it --rm \
  --network host \
  --user haproxy:haproxy \
  -v $PWD/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg \
  haproxy:2.1

docker run \
  --name haproxy -d --rm --restart always \
  --network host \
  -v $PWD/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg \
  haproxy:2.1
