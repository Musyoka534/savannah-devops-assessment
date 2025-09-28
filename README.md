# Simple Web Application

## Overview
This repository contains a simple web application built with **HTML, CSS, and JavaScript**.  
It was created as part of a Technical Devops Assessment.

## Task 1: Version Control Integration

### Objective:
Set up a Git repository for a simple web application, make meaningful commits, and push the repository to a remote Git server.

### Approach:

- Created a public repository on GitHub and cloned it locally.

- Added a simple web app consisting of:

    - index.html (main entry point)

    - style.css (basic styling)

    - app.js (JavaScript functionality)

- Staged and committed the changes with clear, descriptive commit messages,Opened Pull requests against the main branch and merged code.

> **Note:** The source code for Task 1 is located in the **`simple-web-app`** folder.


## Task 2: Containerization with Docker

This task involves containerizing the sample web application using **Docker**.  
The container runs an **Nginx server** to serve the static web files.

---

## How to Build & Run the Container

### 1. Navigate to the Project Root
Go to the folder where the `Dockerfile` is located.  
In this case:  

```bash
cd simple-web-app
```
### 2 . Build the Docker Image
Run the following command to build the Docker image:

```bash
docker build -t sample-web-app .
```

### Run the Container

Run the container and map port 8080 on your host to port 80 inside the container:

```bash
docker run -d -p 8080:80 sample-web-app
```
### Access the Application

Once the container is running, open your browser and navigate to:

```bash
http://localhost:8080
```
You should see the sample web application being served by Nginx.

## Bonus Sub-task: Docker Compose (Multi-Container)

In addition to containerizing the simple web app, a **Docker Compose setup** is included to simulate a multi-container environment consisting of:

- **Web App** (served via Nginx)  
- **Postgres Database** (for local development/testing)  

The `docker-compose.yml` file is available in the **`simple-web-app`** folder.

---

### Run with Docker Compose

From the `simple-web-app` folder, run:

```bash
docker-compose up --build
```

## Task 3: Infrastructure as Code (IaC) (DevOps and Cloud Engineering)
### Objective:
Use an IaC tool of your choice(Terraform, Pulumi, CloudFormation, Bicep or OpenTofu) to define and deploy resources.
### Approach:
I chose Terraform because it is cloud-agnostic, making the infrastructure definitions portable and reusable across different cloud providers.
I deployed resources on AWS cloud, including networking, compute, and Kubernetes infrastructure. This setup lays the foundation for deploying the containerized application in Task 4 on Amazon EKS with load balancing.

#### 1.Networking (VPC & Subnets)

- Created a VPC with both public and private subnets across multiple Availability Zones.

- Attached an Internet Gateway and configured route tables for public subnet internet access.

- Created private subnets for the EKS worker nodes to improve security.

#### 2.Security Groups

- Created a security group for the EC2 instance with: Ports 22 open for SSH and 80(http) for web traffic.

- Created security groups for the EKS cluster and nodes, allowing secure communication between control plane, worker nodes, and load balancers.

#### 3.EC2 Instance with Static IP

- Provisioned an EC2 instance

- Used Terraform tls_private_key and aws_key_pair to automatically generate and manage SSH keys.

- Associated an Elastic IP (EIP) to ensure the instance has a static public IP.

#### 4.EKS Cluster Setup

- provisioned an EKS cluster with worker node groups inside private subnets.

- Integrated with IAM roles for cluster and node authentication.

#### 5.AWS Load Balancer Controller

- Deployed the AWS Load Balancer Controller into the EKS cluster via Terraform Helm provider.

- This enables the cluster to provision Application Load Balancers (ALB) and Network Load Balancers (NLB) for Kubernetes Ingress resources.

- Configured IAM policies via Terraform to grant the controller permissions for managing AWS load balancers.