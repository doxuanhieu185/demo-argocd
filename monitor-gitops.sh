#!/bin/bash

echo "=== Monitoring GitOps Process ==="
echo

echo "1. ArgoCD Application Status:"
kubectl get app demo-static-site -n argocd -o jsonpath='{.status.sync.status}' 2>/dev/null || echo "App not found"
echo

echo "2. Current Image in Deployment:"
kubectl get deployment demo-static-site -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null || echo "Deployment not found"
echo

echo "3. Image Updater Logs (last 10 lines):"
kubectl logs deployment/argocd-image-updater -n argocd --tail=10 2>/dev/null || echo "Image Updater not found"
echo

echo "4. Recent Git Commits:"
git log --oneline -5 2>/dev/null || echo "Not in git repo"
echo

echo "5. Pod Status:"
kubectl get pods -l app=demo-static-site 2>/dev/null || echo "No pods found"
