# iVolve CI/CD Infrastructure

A comprehensive end-to-end CI/CD infrastructure for containerized applications, featuring AWS infrastructure provisioning, automated configuration management, continuous integration, and GitOps-based deployment to Kubernetes.

## Project Archticture 



## 🚀 Architecture Overview

This project implements a complete DevOps infrastructure with the following major components:

### 1. AWS Infrastructure (Terraform Provisioned)
* **EC2 Instance 1 (Master)**:
   * Hosts Jenkins Master that controls the CI pipeline
   * Runs SonarQube for code quality analysis
   * Configured with Ansible playbooks
* **EC2 Instance 2 (Slave)**:
   * Jenkins Slave node for executing build jobs
   * Handles resource-intensive pipeline tasks
   * Configured with Ansible playbooks
* **Supporting Services**:
   * S3 Bucket for Terraform state backend
   * CloudWatch for monitoring and logging

### 2. Local Development Environment
* **Minikube Cluster**:
   * Local Kubernetes implementation for testing
   * Contains dedicated "iVolve" namespace
   * Manages Deployments, Services, and Ingress resources

### 3. ArgoCD Implementation
* **Core Components**:
   * Application Controller for state management
   * Repository Server for cached repositories
   * API Server for RESTful operations
   * GitOps Engine for synchronization logic
* **Workflow**:
   * Monitors GitHub repository for manifest changes
   * Automatically syncs configurations to Kubernetes
   * Maintains desired state defined in Git

### 4. CI/CD Pipeline Flow
1. Code is pushed to GitHub repository
2. Jenkins Master detects changes and assigns build job to Slave
3. Jenkins Slave executes pipeline steps:
   * Runs unit tests
   * Performs SonarQube analysis
   * Builds JAR file
   * Creates Docker image
   * Pushes image to registry
   * Updates Kubernetes manifests
   * Commits changes back to Git repository
4. ArgoCD detects manifest changes in repository
5. ArgoCD syncs changes to Minikube cluster
6. Application is deployed/updated in the local environment

## 📋 Prerequisites

- AWS account with appropriate permissions
- Docker installed
- Kubernetes cluster (Minikube for local testing)
- Git installed
- Basic knowledge of Terraform, Ansible, Jenkins, and Kubernetes

## 🛠️ Project Components

### Terraform

Contains Infrastructure as Code (IaC) configurations for AWS resources:
- VPC and subnet configuration
- EC2 instances for Jenkins Master and Slave
- Security groups and networking
- CloudWatch monitoring setup

[Go to Terraform documentation →](./Terraform/README.md)

### Ansible

Contains configuration management scripts to set up:
- Jenkins Master with SonarQube
- Jenkins Slave configuration
- All necessary dependencies and services

[Go to Ansible documentation →](./Ansible/README.md)

### Jenkins

Contains pipeline configurations for CI/CD:
- Jenkinsfile with complete pipeline definition
- Shared libraries for common operations
- SonarQube integration setup

[Go to Jenkins documentation →](./Jenkins/README.md)

### Docker

Contains application Dockerfile and build context:
- Multi-stage build process
- Optimized container configuration
- Spring Boot application containerization

[Go to Docker documentation →](./Docker/README.md)

### Kubernetes

Contains Kubernetes manifests for application deployment:
- Deployment, Service, and Ingress configurations
- Persistent storage setup
- Namespace isolation

[Go to Kubernetes documentation →](./Kubernetes/README.md)

### ArgoCD

Contains GitOps configuration for continuous deployment:
- Application definition
- Sync policies
- Repository integration

[Go to ArgoCD documentation →](./ArgoCD/README.md)

## 📝 Project Structure

```
├── Ansible/               # Ansible playbooks and roles
├── ArgoCD/                # ArgoCD configuration files
├── Docker/                # Dockerfile and application source
├── Jenkins/               # Jenkinsfile and pipeline configs
├── Kubernetes/            # Kubernetes manifest files
├── Terraform/             # Terraform IaC configurations
└── README.md              # This file
```

