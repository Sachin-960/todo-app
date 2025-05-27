# Todo App with Node.js + MongoDB on AWS

A simple todo application built with **Node.js**, **MongoDB**, and **Docker Compose**, deployed automatically to **AWS EC2** using **Terraform**, **Ansible**, and **GitHub Actions CI/CD**.

---

## ✅ Features

- RESTful API endpoints for managing todos:
  - `GET /todos`
  - `POST /todos`
  - `GET /todos/:id`
  - `PUT /todos/:id`
  - `DELETE /todos/:id`
- Data stored in MongoDB
- Fully automated deployment to AWS
- Secure IP extraction
- Auto-cleanup on failure
- No need for Docker Hub (builds directly on server)

---

## 🧾 Folder Structure

```
todo-app/
│
├── api/
│   ├── Dockerfile
│   ├── package.json
│   └── server.js
│
├── docker-compose.yml
├── .dockerignore
├── main.tf
└── .github/workflows/deploy.yml
```

---

## 🛠️ Technologies Used

| Tool | Description |
|------|-------------|
| Node.js | Backend server |
| Express | Web framework |
| MongoDB | Database |
| Docker | Containerization |
| Docker Compose | Orchestration |
| Terraform | Infrastructure as Code |
| GitHub Actions | CI/CD Pipeline |
| AWS EC2 | Cloud hosting |
| Ansible (Optional) | Server configuration |

---

## 📦 Local Development

### Prerequisites

- Docker & Docker Compose installed
- Node.js (optional for dev)

### Run Locally

```bash
docker-compose up --build
```

Then access the app at: `http://localhost:3000/todos`

---

## 🚀 Deploy to AWS

This project uses GitHub Actions to deploy the app to AWS.

### 🔐 Required GitHub Secrets

Add these secrets to your GitHub repo under **Settings > Secrets and variables > Actions**:

| Secret Name             | Description                                                                 |
|-------------------------|-----------------------------------------------------------------------------|
| `AWS_ACCESS_KEY_ID`     | AWS access key ID                                                           |
| `AWS_SECRET_ACCESS_KEY` | AWS secret access key                                                       |
| `SSH_PRIVATE_KEY`       | Private SSH key matching the key pair used in Terraform                     |
| `KEY_PAIR_NAME`         | The name of the EC2 key pair you're using                                   |

> Make sure your key pair is added to your AWS account and matches the region.

---

## 🧪 GitHub Actions Workflow

On every push to `main`, this happens:

1. Terraform provisions an EC2 instance on AWS
2. Docker & Docker Compose are installed via `apt`
3. Your code is cloned from GitHub
4. App is built and started via Docker Compose
5. Success message shows the URL to access the app
6. On failure, infrastructure is destroyed automatically

---

## 🌐 Access the App

After successful deployment, the GitHub Action will print:

```
✅ App deployed successfully!
👉 Access your app at: http://<INSTANCE_IP>:3000/todos
```

You can use tools like `curl`, Postman, or a browser to test the endpoints.

Example:

```bash
curl http://<INSTANCE_IP>:3000/todos
```

---

## 🧹 Auto Cleanup on Failure

If any step fails during deployment, the workflow will automatically run:

```bash
terraform destroy -auto-approve
```

to remove the EC2 instance and avoid orphaned resources.

---

---

## 🤝 Contributing

Contributions are welcome! Feel free to open issues or PRs.

---
