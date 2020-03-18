cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: nodejs-service
spec:
  ports:
    - name: http
      protocol: TCP
      port: 80
      targetPort: http
EOF


cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nodejs-deployment
  labels:
    app: nodejs
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nodejs
  template:
    metadata:
      labels:
        app: nodejs
    spec:
      containers:
      - name: nodejs
        image: kwonghung/plain-react-app:node_12
        ports:
        - name: http
          protocol: TCP
          containerPort: 3000
---
apiVersion: v1
kind: Service
metadata:
  name: nodejs-service
spec:
  selector:
    app: nodejs
  ports:
    - protocol: TCP
      port: 80
      targetPort: 3000
EOF

docker run \
  -it --rm \
  -p 3000:3000 \
  kwonghung/plain-react-app:node_12
