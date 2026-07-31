# 🚀 Capstone Phoenix API

An automated, containerized Node.js REST API integrated with Amazon RDS (PostgreSQL), deployed using Docker Compose, managed via Infrastructure as Code (Terraform), and continuously delivered through GitHub Actions.

---

## 🏗️ Architecture Overview

- **Compute & Hosting:** AWS EC2 (Ubuntu 24.04 LTS) running Docker & Docker Compose.
- **Database Layer:** AWS RDS PostgreSQL (Multi-AZ compatible security groups, automated backups).
- **Infrastructure Management:** Terraform for provisioning VPC resources, EC2 instances, and RDS database nodes.
- **Continuous Deployment (CI/CD):** GitHub Actions executing SSH deployment workflows upon pushes to main.
- **Orchestration Manifests:** Kubernetes Deployment, Service (LoadBalancer), ConfigMap, and Secret manifests included for K8s container orchestration.

---

## 📁 Repository Structure

capstone-phoenix/
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions CI/CD workflow
├── infra/
│   └── terraform/              # Infrastructure provisioning scripts
│       ├── main.tf
│       └── global-bundle.pem   # AWS RDS SSL certificate bundle
├── manifests/                  # Kubernetes manifest files
│   ├── configmap.yaml
│   ├── secret.yaml
│   ├── deployment.yaml
│   └── service.yaml
├── app.js                      # Node.js API server (RDS Connection & Health Check)
├── Dockerfile                  # Container definition for Node.js app
├── docker-compose.yml          # Production container configuration
└── package.json                # Node.js dependencies

---

## ⚡ API Endpoints

### GET /
Returns system health status, DB connectivity confirmation, and current PostgreSQL server timestamp.

```json
{
  "status": "healthy",
  "message": "Capstone Phoenix API v2 connected to RDS PostgreSQL!",
  "db_time": "2026-07-29T16:26:11.605Z"
}
