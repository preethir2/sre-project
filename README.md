# 🚀 SRE Project – Distributed System on k3s

## 📌 Overview

This project demonstrates a distributed system using Kubernetes (k3s), NATS messaging, and real-time communication via WebSockets.

---

## 🧱 Architecture

UI → API → NATS → Worker → WebSocket → UI

---

## 🧩 Services

### UI Service
- Simple frontend (HTML + JS)
- Sends messages and displays real-time updates

### API Service
- REST API (Node.js)
- Endpoint: /api/send
- Sends messages to NATS

### Worker Service
- Subscribes to NATS
- Processes messages

### WebSocket Service
- Maintains persistent connections
- Broadcasts messages to UI

---

## 🔄 Communication Flow

### Asynchronous (Event-driven)
UI → WebSocket → NATS → Worker → WebSocket → UI

### Synchronous
UI → API → Kubernetes ClusterIP service

### External Access
- Traefik Ingress exposes:
  - UI → /
  - API → /api
  - WebSocket → /ws

---

## 📦 MinIO

MinIO is used as object storage inside Kubernetes.

- S3-compatible storage
- Can be used for storing files and backups
- In this project, deployed as a lightweight storage service

---

## 🔐 OPA Policy

OPA enforces:

👉 All containers must have resource limits

### Test:

```bash
kubectl run test --image=busybox -- sh
