openssl genrsa -out my-service.key -passout pass:abcd1234 2048

openssl req -new -key my-service.key -out my-service.csr -config my-service.config

openssl req -in my-service.csr -text

openssl x509 -req -in my-server.csr -CA my-rootCA.crt -CAkey my-rootCA.key -CAcreateserial -out my-service.crt -days 30 -sha256
