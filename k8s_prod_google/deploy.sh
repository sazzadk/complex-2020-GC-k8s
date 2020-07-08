docker build -t sazzadk/complex-client:latest -t sazzadk/complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t sazzadk/complex-server:latest -t sazzadk/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t sazzadk/complex-worker:latest -t sazzadk/complex-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sazzadk/complex-client:latest
docker push sazzadk/complex-server:latest
docker push sazzadk/complex-worker:latest

docker push sazzadk/complex-client:$SHA
docker push sazzadk/complex-server:$SHA
docker push sazzadk/complex-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sazzadk/complex-server:$SHA
kubectl set image deployments/client-deployment client=sazzadk/complex-client:$SHA
kubectl set image deployments/worker-deployment worker=sazzadk/complex-worker:$SHA