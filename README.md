# Library System DevOps Repository

This repository contains the deployment configuration and infrastructure as code for the Library Management System. It orchestrates the deployment of three interconnected repositories to form a complete library management solution.

## System Overview

The Library Management System consists of three main components:

1. **Frontend** ([library-system-devops/library-frontend](https://github.com/library-system-devops/library-frontend))
    - React-based SPA
    - Material UI components
    - Role-based access control
    - JWT authentication

2. **Backend** ([library-system-devops/library-backend](https://github.com/library-system-devops/library-backend))
    - Spring Boot application
    - REST API endpoints
    - MySQL database integration
    - JWT authentication
    - Role-based security

3. **DevOps** (Current repository)
    - Deployment automation
    - Docker containerization
    - GitHub Actions CI/CD
    - Infrastructure configuration

## System Architecture

```
                           ┌─────────────────┐
                           │  GitHub Actions │
                           │    Workflow     │
                           └────────┬────────┘
                                   │
                                   ▼
┌─────────────────┐      ┌─────────────────┐      ┌─────────────────┐
│    Frontend     │      │    Backend      │      │     MySQL       │
│    Container    │──────│    Container    │──────│    Container    │
│    (Nginx)      │      │  (Spring Boot)  │      │   (Database)    │
└─────────────────┘      └─────────────────┘      └─────────────────┘
        Port 80                Port 8080               Port 3306
```

## Prerequisites

- Google Cloud Platform VM
- Docker and Docker Compose installed on the VM
- GitHub organization access
- SSH access to the VM

## Repository Structure

```
library-devops/
├── .github/
│   └── workflows/
│       └── deploy.yml       # GitHub Actions deployment workflow
├── docker-compose.yml       # Docker Compose configuration
└── README.md               # This file
```

## Environment Variables

The following secrets must be configured in GitHub repository settings:

```
GH_PAT                 # GitHub Personal Access Token
GCP_VM_IP              # VM IP Address
GCP_SSH_USERNAME       # VM SSH Username
GCP_SSH_PRIVATE_KEY    # VM SSH Private Key
MYSQL_ROOT_PASSWORD    # MySQL Root Password
MYSQL_USER             # Application Database User
MYSQL_PASSWORD         # Application Database Password
JWT_SECRET             # JWT Signing Secret
JWT_EXPIRATION         # JWT Token Expiration Time
```

## Deployment Process

1. **Repository Checkout**
    - Checks out all three repositories using GitHub PAT
    - Places them in the correct directory structure

2. **File Transfer**
    - Copies necessary files to the VM
    - Sets up correct directory structure
    - Transfers Docker and configuration files

3. **Environment Setup**
    - Creates `.env` file with necessary secrets
    - Sets up Docker networking

4. **Container Deployment**
    - Builds and starts containers using Docker Compose
    - Sets up container networking
    - Initializes database with schema

5. **Verification**
    - Checks container status
    - Verifies network connectivity
    - Validates deployment success

## Continuous Deployment

The system uses GitHub Actions for continuous deployment:

1. Triggers on push to main branch
2. Performs repository checkouts
3. Executes deployment process
4. Verifies deployment success

## Manual Deployment

If needed, manual deployment can be performed:

```bash
# SSH into the VM
ssh username@vm-ip

# Navigate to deployment directory
cd ~/library-system

# Pull latest changes
git pull

# Deploy using Docker Compose
docker compose up -d --build
```

## Monitoring and Logs

View container logs:
```bash
# All containers
docker compose logs

# Specific container
docker compose logs [frontend|backend|mysql]

# Follow logs
docker compose logs -f
```

Check container status:
```bash
docker ps
```

## Troubleshooting

1. **Container Issues**
   ```bash
   # Restart containers
   docker compose restart

   # Rebuild containers
   docker compose up -d --build
   ```

2. **Database Issues**
   ```bash
   # Check MySQL logs
   docker compose logs mysql
   ```

3. **Network Issues**
   ```bash
   # List networks
   docker network ls

   # Inspect network
   docker network inspect library-network
   ```