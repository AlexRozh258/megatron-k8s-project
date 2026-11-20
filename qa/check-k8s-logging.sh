#!/usr/bin/env bash
set -euo pipefail

TAG="QA_LOKI_SMOKE_$(date +%s)"

echo "=== 1. Node & Resources ==="
kubectl get nodes -o wide
kubectl describe node | grep -A 8 "Allocated resources:" || true

echo -e "\n=== 2. StorageClass & PVC ==="
kubectl get storageclass || true
kubectl get pvc -A || true

echo -e "\n=== 3. CoreDNS, Monitoring & Logging Pods ==="
kubectl get pods -n kube-system -l k8s-app=kube-dns -o wide || true
kubectl get pods -n monitoring -o wide || true
kubectl get pods -n logging -o wide || true

echo -e "\n=== 4. Emit OS test log entry ==="
logger -t qa-logging-check "$TAG"
echo "Emitted syslog tag: $TAG"
echo "Check in Grafana (Loki) with query containing: $TAG"
