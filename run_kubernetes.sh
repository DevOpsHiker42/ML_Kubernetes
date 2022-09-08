#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# Set Docker ID/path
dockerpath="devopshiker42/boston-housing:v1.0.0"

# Step 2
# Run the Docker Hub container with kubernetes
minikube image load $dockerpath
kubectl run boston-housing --image=$dockerpath --port=80 --labels app=boston-housing

# Step 3:
# List kubernetes pods
kubectl get pods

# Step 4:
# Forward the container port to host once pod ready
kubectl wait --for=condition=ready pod -l app=boston-housing
kubectl port-forward boston-housing 8000:80

