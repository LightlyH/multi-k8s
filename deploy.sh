docker build -t lilyh/multi-client:latest -t lilyh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lilyh/multi-server:latest -t lilyh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lilyh/multi-worker:latest -t lilyh/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lilyh/multi-client:latest
docker push lilyh/multi-server:latest
docker push lilyh/multi-worker:latest

docker push lilyh/multi-client:$SHA
docker push lilyh/multi-server:$SHA
docker push lilyh/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lilyh/multi-server:$SHA
kubectl set image deployments/client-deployment client=lilyh/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lilyh/multi-worker:$SHA