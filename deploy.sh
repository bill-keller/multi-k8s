docker build -t billkeller/multi-client:latest -t billkeller/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t billkeller/multi-server:latest -t billkeller/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t billkeller/multi-worker:latest -t billkeller/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push billkeller/multi-client:latest
docker push billkeller/multi-server:latest
docker push billkeller/multi-worker:latest
docker push billkeller/multi-client:$SHA
docker push billkeller/multi-server:$SHA
docker push billkeller/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=billkeller/multi-client:$SHA
kubectl set image deployments/server-deployment server=billkeller/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=billkeller/multi-worker:$SHA