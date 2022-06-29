#!/bin/bash
# Gets the image from docker hub and deploys it
kubectl apply -f sample-app-deployment.yaml
# enables ingress add on in mini kube 
minikube addon enable ingress || echo "Failed to enable minikube ingress addon";
# Activates ingress in minikube to allow access of the pod over port 80 and by name (sample.app)
kubectl apply -f ingress.yml
# On mac I needed to use this on a seperate terminal to keep the ingress tunnel up but i am not sure if it is needed in windows
# minikube tunnel
# applies the scale configuration to the deployment
kubectl apply -f scale-sample-app.yaml
# used to test the deployment autoscaling by increasing or decreasing load-test pod count
# kubectl apply -f load-test-deployment.yaml
