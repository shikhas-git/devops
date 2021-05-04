#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
dockerpath=shikhas/demopred

# Step 2
# Run the Docker Hub container with kubernetes
minikube kubectl -- create deployment demopredict-app --image=docker.io/shikhas/demopred


# Step 3:
# List kubernetes pods
minikube kubectl -- get pods
export POD_NAME=$(minikube kubectl -- get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
#echo name of the pod
echo Name of the Pod: $POD_NAME

# Step 4:
# Forward the container port to a host
minikube kubectl -- expose deployment/demopredict-app --type="NodePort" --port 8090
minikube kubectl -- port-forward pod/$POD_NAME 8090:80

