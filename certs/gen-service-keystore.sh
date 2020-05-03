openssl genrsa -out my-service.key -passout pass:abcd1234 2048

openssl req -new \
  -key my-service.key -out my-service.csr \
  -config my-service.config

openssl req -in my-service.csr -text

openssl x509 -req \
  -in my-service.csr -out my-service.crt -passin pass:abcd1234 \
  -CA my-rootCA.crt -CAkey my-rootCA.key -CAcreateserial \
  -days 30 -sha256

openssl x509 -in my-service.crt -text
