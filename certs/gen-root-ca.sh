openssl genrsa -aes-256-cbc -passout pass:abcd1234 -out my-rootCA.key 4096
openssl req -x509 -new -nodes -key my-rootCA.key --passin pass:abcd1234 -sha256 -days 30 -out my-rootCA.crt
