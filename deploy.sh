docker build -t yimingl1/multi-client:latest -t yimingl1/multi-client:$SHA -f ./cleint/Dockerfile ./client
docker build -t yimingl1/multi-server:latest -t yimingl1/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yimingl1/multi-worker:latest -t yimingl1/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push yimingl1/multi-client:latest
docker push yimingl1/multi-server:latest
docker push yimingl1/multi-worker:latest
docker push yimingl1/multi-client:$SHA
docker push yimingl1/multi-server:$SHA
docker push yimingl1/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yimingl1/multi-server:$SHA
kubectl set image deployments/client-deployment client=yimingl1/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yimingl1/multi-worker:$SHA