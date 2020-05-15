rm trust.crt trust.p12

openssl s_client \
  -connect localhost:8080 \
  -CAfile my-rootCA.crt \
  -showcerts -certform PEM \
  </dev/null 2>/dev/null | \
  sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > trust.crt
  
openssl pkcs12 -export \
  -out trust.p12 -passout pass:abcd1234 \
  -nokeys -in trust.crt
  
openssl pkcs12 -in trust.p12 -passin pass:abcd1234 -info
