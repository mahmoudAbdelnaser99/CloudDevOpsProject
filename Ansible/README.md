# Jenkins Infrastructure Configuration with Ansible
Jenkins Ansible Role - Automated Setup with Suggested Plugins and BlueOcean UI on AWS
This repository provides a **complete Ansible-based solution** for **automated deployment** and **management** of a Jenkins CI/CD infrastructure on AWS EC2 instances.

It uses a **dynamic inventory** to discover and manage EC2 instances based on their **tags**, grouping them automatically for **targeted playbook execution**. It can **fallback to a static inventory** if dynamic discovery fails.

---

## 🚀 Features

- **Dynamic EC2 Inventory**: Automatically discovers instances based on AWS tags.
- **Role-Based Configuration**: Modular and organized Ansible roles for components.
- **Modular Playbooks**: Main and task-specific playbooks for flexibility.
- **Environment Configuration**: Ensures environment readiness (system limits, permissions, etc.).
- **Service Management**: Configures systemd services and dependencies.
- **Complete CI/CD Setup**: Jenkins (with agents) 
- **Dockerized Environment**: Docker installed and configured across all nodes.
- Creating an admin user via Groovy script
- Automatic installation of all suggested Jenkins plugins (including BlueOcean)
- Ensuring Jenkins is enabled and running

---

## 📋 Prerequisites

- AWS CLI configured with valid credentials.
- Terraform-deployed AWS Infrastructure (see [`Terraform/`](./terraform) directory).
- Python 3.x installed with pip.
- Ansible 2.9+ installed.
- EC2 Key Pair (`jenkins-key.pem`) available and permissions set.

Install required Python packages:

```bash
pip install ansible boto3 botocore
```
create Roles
```bash
ansible-galaxy init roles/common
ansible-galaxy init roles/git
ansible-galaxy init roles/java
ansible-galaxy init roles/docker
ansible-galaxy init roles/jenkins
```

Set key pair permissions:

```bash
chmod 400 ~/jenkins-key.pem
```

---

## 📂 Directory Structure

```
├── ansible.cfg             # Ansible configuration file
├── inventory/              # Dynamic inventory configuration for AWS
│   └── ec2.yaml
├── playbooks/              # Playbooks for different node types
│   ├── site.yml            # Full infrastructure setup
│   ├── jenkins-master.yml          # Jenkins master setup
│   ├── jenkins-slave.yml           # Jenkins slave setup
│   └── kubeadm.yaml                # kubeadm setup
├── roles/                  # Ansible roles
    ├── common/             # Common setup (packages, users, etc.)
    ├── java/               # Java installation
    ├── docker/             # Docker installation and configuration
    ├── jenkins_master/     # Jenkins master setup
    ├── jenkins_slave/      # Jenkins slave setup
    └── kubeadm/            # kubeadm master + node1 setup

```

---

## ⚙️ Usage

### 1. Verifying Dynamic Inventory

Check if instances are correctly grouped:

```bash
ansible-inventory --graph
```
![Alt text](assets/pic1.png)

---

### 2. Running Playbooks

- Configure **all instances**:

```bash
ansible-playbook playbooks/site.yml
ansible-playbook playbooks/kubeadm.yaml
```

---

## 🌐 Accessing Services

After playbook execution:

- **Jenkins**:  
  http://<master_public_ip>:8080  
  Username: `admin`  
  Password: `admin123` (or as set in `group_vars`)

![Alt text](assets/pic2.png)

---

## 🔧 Components Installed

### Master Node

- Java 17
- Git, Docker, and essential packages
- Jenkins (with pre-installed plugins)

### Slave Node

- Java 17
- Git, Docker, and essential packages
- Jenkins agent (configured to connect to the master automatically)

---

## 📑 Role-Based Configuration Overview

- **Common Role**:  
  Sets up basic system packages, users, and permissions.

![Alt text](assets/pic7.png)

- **Java Role**:  
  Installs and configures Java 17.

![Alt text](assets/pic6.png)

- **Docker Role**:  
  Installs Docker, adds necessary users to the Docker group.

![Alt text](assets/pic5.png)

- **Jenkins Master Role**:  
  Installs Jenkins, configures plugins, sets admin credentials.

- **Jenkins Slave Role**:  
  Installs and configures Jenkins agent.

- **kubeadm Role**:  
  Initialize Kubernetes master , node1 through script
  copy admin.conf to user's kube config
  apply Flannel CNI plugin

![Alt text](assets/pic8.png)

- **Join node1 to master**:  
  generate kubeadm join
  Join the node to the Kubernetes cluster

![Alt text](assets/pic9.png)

![Alt text](assets/pic11.png)
---

## 🛠️ Service Management

- Creates **systemd service files** for Jenkins.
- Ensures services **start automatically on boot**.
- Handles service **dependencies** properly.

---

## 🏷️ EC2 Tag Requirements

Make sure your EC2 instances are tagged appropriately:

- Tag key: `Project`
- Tag value: `ivolve`


---

## 📈 Benefits

✅ Highly scalable and modular setup  
✅ Automated CI/CD foundation ready for production  
✅ Easy to extend and maintain  
✅ Docker-ready for microservice deployments
✅ Automated Jenkins Setup with Suggested Plugins
✅ Setup Kubernetes Cluster on AWS 




