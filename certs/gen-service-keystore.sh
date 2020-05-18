rm my-service.key my-service.csr my-service.crt my-service.p12

openssl genrsa -out my-service.key -passout pass:abcd1234 2048

openssl req -new \
  -key my-service.key -out my-service.csr \
  -config my-service.config

openssl req -newkey rsa:2048 \
  -nodes -sha256 -keyout my-service.key \
  -out my-service.csr \
  -config my-service.config
  
#-subj '/C=HK/L=Hong Kong/CN=localhost/subjectAltName=DNS.1=localhost'

openssl req -in my-service.csr -text

openssl x509 -req \
  -in my-service.csr -out my-service.crt -passin pass:abcd1234 \
  -CA my-rootCA.crt -CAkey my-rootCA.key -CAcreateserial \
  -days 30 -sha256 \
  -extfile my-service.config -extensions req_ext

openssl x509 -in my-service.crt -text

openssl pkcs12 -export -out my-service.p12 -passout pass:abcd1234 \
  -inkey my-service.key --name my-cert -in my-service.crt \
  -certfile my-rootCA.crt

openssl pkcs12 -nokeys -info \
  -in my-service.p12 -passin pass:abcd1234
  
kubectl create secret \
  generic my-service-p12 \
  --from-file=my-service-p12=./my-service.p12 \
  --from-literal=my-service-p12-cred=abcd1234

