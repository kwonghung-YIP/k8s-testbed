openssl genrsa -out my-service.key -passout pass:abcd1234 2048

openssl req -new -key my-service.key -out my-service.csr -config my-service.config
