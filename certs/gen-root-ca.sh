openssl genrsa -aes-256-cbc -passout pass:abcd1234 -out my-rootCA.key 4096

openssl req -verbose -x509 -new \
  -key my-rootCA.key --passin pass:abcd1234 \
  -nodes -sha256 -days 30 -config my-rootCA.config \
  -out my-rootCA.crt

openssl x509 -in my-rootCA.crt -text -noout

kubectl create secret \
  generic my-root-ca \
  --from-file=my-rootCA-key=./my-rootCA.key \
  --from-file=my-rootCA-crt=./my-rootCA.crt \
  --from-literal=my-rootCA-key-cred=abcd1234

kubectl apply -f cert-manager.yaml
