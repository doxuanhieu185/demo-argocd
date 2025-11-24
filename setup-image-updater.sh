#!/bin/bash

echo "Installing ArgoCD Image Updater..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/master/manifests/install.yaml

echo "Waiting for Image Updater to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/argocd-image-updater -n argocd

echo "ArgoCD Image Updater installed successfully!"
echo "You can check status with: kubectl get pods -n argocd | grep image-updater"
