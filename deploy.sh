docker build -t bhoopendra/multi-client:latest -t bhoopendra/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bhoopendra/multi-server:latest -t bhoopendra/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bhoopendra/multi-worker:latest -t bhoopendra/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bhoopendra/multi-client:latest
docker push bhoopendra/multi-server:latest
docker push bhoopendra/multi-worker:latest

docker push bhoopendra/multi-client:$SHA
docker push bhoopendra/multi-server:$SHA
docker push bhoopendra/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=bhoopendra/multi-server:$SHA
kubectl set image deployments/client-deployment client=bhoopendra/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bhoopendra/multi-worker:$SHA