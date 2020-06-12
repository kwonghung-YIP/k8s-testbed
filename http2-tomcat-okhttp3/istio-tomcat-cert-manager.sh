rm istio-my-rootCA.key istio-my-rootCA2.key istio-my-rootCA2.crt

openssl genrsa -aes-256-cbc --passout pass:abcd1234 -out istio-my-rootCA.key 4096

openssl rsa -in istio-my-rootCA.key --passin pass:abcd1234 -out istio-my-rootCA2.key

openssl req -verbose -x509 -new \
  -key istio-my-rootCA2.key --passin pass:abcd1234 \
  -nodes -sha256 -days 30 -config my-rootCA.config \
  -out istio-my-rootCA2.crt

openssl x509 -in istio-my-rootCA2.crt -text -noout

kubectl create secret \
  tls my-rootCA \
  --name-space=istio-system
  --key=./istio-my-rootCA2.key \
  --cert=./istio-my-rootCA2.crt

kubectl apply -f istio-tomcat-cert-manager.yaml
