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
