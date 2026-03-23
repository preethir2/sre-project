#!/bin/bash

set -e

echo "🚀 Starting k3s cluster setup..."

# Install k3s (master)
curl -sfL https://get.k3s.io | sh -

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

echo "⏳ Waiting for cluster..."
sleep 10

kubectl get nodes

echo "📦 Installing Argo CD..."
kubectl create namespace argocd || true
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "📦 Installing Argo Workflows..."
kubectl create namespace argo || true
kubectl apply -n argo -f https://raw.githubusercontent.com/argoproj/argo-workflows/stable/manifests/install.yaml

echo "📦 Applying infrastructure..."
kubectl apply -f infra/

echo "📦 Applying apps..."
kubectl apply -f apps/

echo "📦 Applying workflows..."
kubectl apply -f workflows/

echo "✅ Setup complete!"
