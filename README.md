# Mini Cluster

## Table of Contents
- [Summary](#summary)
- [Details](#details)
- [Solution](#solution)

## Summary
Imagine that you have a kubernetes cluster. This cluster orchestrates many services behind the load balancer.

## Details
- Clone the GitHub repo on your local which is specified as [sample-app](sample-app/).
- Create a docker file for building a .net core web app within the docker image.
- You need to create a DockerHub account for uploading image.
- Build a docker image and upload this to the DockerHub.
- End to End HTTP communication is Ok for this case study.
- Create a kubernetes definition file for :
     - Create one ingress for handling HTTP requests from outside the cluster 
     - Create one service for load balancing across the pods 
     - Create a deployment with two pods that are hosting our app instances from DockerHub (which is you've uploaded).
- You should be able to test the application with the following URL pattern with HTTP GET request when you complete it :
     - > http://{{IP}}:{{Port}}/WeatherForecast

- You could prepare one-click install script file as bash or shell to install and run the mini-cluster.

## Solution
### build image
docker build --pull -t raafeh/sample-app . --progress=plain --no-cache
### for testing image created
    docker run --rm -it -p 8000:80 sample-app --name sample-app-running
### push to hub
docker push raafeh/sample-app:latest


### install minikube and run pod on it
# expect minikube to be installed on the system otherwise these commands
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64\nsudo install minikube-darwin-amd64 /usr/local/bin/minikube
sudo install minikube-darwin-amd64 /usr/local/bin/minikube\n
minikube start

### ingress
# Gets the imaghe from docker hub and deploys the image
kubectl apply -f sample-app-deployment.yaml
# Activates ingress in minikube to allow access of the pod over port 80 and by name (sample.app)
minikube addon enable ingress
kubectl apply -f ingress.yml
# on mac we needed to use this to open the ingress 
minikube tunnel &
# applies the scale configuration to the deployment
kubectl apply -f scale-sample-app.yaml
# used to test the deployment autoscaling by increasing or decreasing load-test pod count
kubectl apply -f load-test-deployment.yaml