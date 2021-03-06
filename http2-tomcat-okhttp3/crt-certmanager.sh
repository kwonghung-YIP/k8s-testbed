rm my-rootCA2.key my-rootCA.key my-rootCA.crt

openssl genrsa -aes-256-cbc --passout pass:abcd1234 -out my-rootCA2.key 4096

openssl rsa -in my-rootCA2.key --passin pass:abcd1234 -out my-rootCA.key

openssl req -verbose -x509 -new \
  -key my-rootCA.key --passin pass:abcd1234 \
  -nodes -sha256 -days 30 -config my-rootCA.config \
  -out my-rootCA.crt

openssl x509 -in my-rootCA.crt -text -noout

kubectl create secret \
  tls my-ca-keypair \
  --key=./my-rootCA.key \
  --cert=./my-rootCA.crt
  
#  --dry-run=true --output=yaml

kubectl apply -f cert-manager.yaml
