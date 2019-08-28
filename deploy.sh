docker build -t jalexanderbryant/k8-client:latest -t jalexanderbryant/k8-client:$SHA -f ./client/Dockerfile ./client
docker build -t jalexanderbryant/k8-server:latest -t jalexanderbryant/k8-server:$SHA -f ./server/Dockerfile ./server
docker build -t jalexanderbryant/k8-worker:latest -t jalexanderbryant/k8-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jalexanderbryant/k8-client:latest
docker push jalexanderbryant/k8-server:latest
docker push jalexanderbryant/k8-worker:latest
docker push jalexanderbryant/k8-client:$SHA
docker push jalexanderbryant/k8-server:$SHA
docker push jalexanderbryant/k8-worker:$SHA


kubectl apply -f k8s

kubectl set image deployments/server-deployment server=jalexanderbryant/k8-server:$SHA
kubectl set image deployments/client-deployment client=jalexanderbryant/k8-client:$SHA
kubectl set image deployments/worker-deployment worker=jalexanderbryant/k8-worker:$SHA

