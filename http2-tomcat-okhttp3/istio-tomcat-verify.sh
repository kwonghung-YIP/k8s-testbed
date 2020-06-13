curl -v -HHost:tomcat-http2.hung.org.hk \
  --resolve "tomcat-http2.hung.org.hk:31944:rancher-node02" \
  --cacert my-rootCA.crt \
  "https://tomcat-http2.hung.org.hk:31944/echo"

curl -vk -HHost:tomcat-http2.hung.org.hk \
  --resolve "tomcat-http2.hung.org.hk:443:istio-ingressgateway.istio-system.svc.cluster.local" \
  "https://tomcat-http2.hung.org.hk/echo"

openssl s_client -showcerts \
  -servername tomcat-http2.hung.org.hk \
  -connect rancher-node02:31944 \
  -CAfile my-rootCA.crt
