  SRE Project – Distributed System on k3s
 Overview

This project demonstrates a production-style distributed system built on Kubernetes (k3s).  
It showcases:

1. Microservices architecture
2.Asynchronous messaging using NATS
3. Real-time communication using WebSockets
4. Ingress-based routing via Traefik
5.Policy enforcement using OPA (Gatekeeper)
6. Object storage using MinIO

Services

UI Service
1. Nginx-based frontend
2. Allows user input
3.Displays real-time updates
4.Communicates via HTTP and WebSocket

 HTTP Service (API)
1.Built using Node.js (Express)
- Endpoints:
  - `GET /api`
  - `POST /api/send`
- Publishes messages to NATS

---

 WebSocket Service
1, Maintains persistent connections
2. Subscribes to NATS
3. Broadcasts messages to UI
4. Accepts messages from UI (async communication)

 Worker Service
1.Subscribes to NATS
2. Processes messages asynchronously

 NATS (Messaging Layer)
1.Enables asynchronous communication
2, Decouples services
- Core of event-driven architecture
 MinIO (Object Storage)
1. S3-compatible storage system
2.Provides persistent storage inside Kubernetes



 Services

 UI Service
1. Nginx-based frontend
2, Allows user input
3. Displays real-time updates
4. Communicates via HTTP and WebSocket



 HTTP Service (API)
1. Built using Node.js (Express)
2. Endpoints:
  - `GET /api`
  - `POST /api/send`
  3. Publishes messages to NATS



 WebSocket Service
1. Maintains persistent connections
2.Subscribes to NATS
3.Broadcasts messages to UI
4. Accepts messages from UI (async communication)



 Worker Service
1. Subscribes to NATS
2. Processes messages asynchronously

 NATS (Messaging Layer)
1, Enables asynchronous communication
2. Decouples services
3. Core of event-driven architecture


 MinIO (Object Storage)
1. S3-compatible storage system
2. Provides persistent storage inside Kubernetes


 Communication Flow

Asynchronous (Event-driven)
1. The UI sends messages via WebSocket
2. WebSocket service publishes messages to NATS
3. Worker service consumes messages from NATS
4. WebSocket service broadcasts updates back to UI
5. Enables real-time, non-blocking communication

Synchrnous (cluster ip)
1. UI communicates with API via HTTP
2. API handles REST requests (`/api`, `/api/send`)
3. Communication happens through Kubernetes internal services


   ARCHITECTURE
           
           
         ```mermaid
flowchart TB

    %% Client Layer
    A["Browser (UI Client)"]

    %% Ingress
    B["Traefik (Ingress / Router)"]

    %% Services Layer
    subgraph Services
        C["UI Service (Nginx)"]
        D["API Service (Node.js)"]
        E["WebSocket Service (Node.js)"]
    end

    %% Messaging Layer
    F["NATS (Messaging System)"]

    %% Consumers
    subgraph Consumers
        G["Worker Service (Consumer)"]
        H["UI Live Updates (WebSocket Push)"]
    end

    %% Storage
    I["MinIO (Object Storage)"]

    %% Flow
    A -->|"HTTP / WS Requests"| B
    B --> C
    B --> D
    B --> E

    D -->|"Publish Events"| F
    E -->|"Subscribe"| F

    F --> G
    F --> H

    G -->|"Store / Retrieve"| I
```
