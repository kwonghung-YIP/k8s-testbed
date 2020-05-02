openssl genrsa -aes-256-cbc -passout pass:abcd1234 -out my-rootCA.key 4096
openssl req -verbose -x509 -new \
  -key my-rootCA.key --passin pass:abcd1234 \
  -nodes -sha256 -days 30 -config my-rootCA.config \
  -out my-rootCA.crt
