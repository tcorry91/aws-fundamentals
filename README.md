# aws-fundamentals

Hands-on AWS & Terraform labs on Windows (PowerShell + Git Bash). Real outputs: screenshots, commands, and notes from building real infrastructure step by step.

---

## 📘 Overview

A full progression from AWS fundamentals to production-grade infrastructure. Covers IAM, EC2, S3, RDS, Terraform, Docker, ECS Fargate, and CloudWatch — with emphasis on least privilege, automation, and reproducible infrastructure.

---

## ✅ Completed Labs

### Week 1 – Core AWS Basics
- **Day 1** — AWS account setup + AWS CLI verification (`aws s3 ls`).
- **Day 2** — Launch EC2, SSH access, security groups, and web server.
- **Day 3** — IAM users, groups, MFA, and least privilege.
- **Day 4** — S3 static website hosting and bucket policies.
- **Day 5** — Bash script to list S3 buckets → `s3_report.txt`.

---

### Week 2 – Roles, RDS, and Policies
- **Day 1** — EC2 lifecycle operations (stop/start/reboot/terminate).
- **Day 2** — EC2 instance role with `AmazonS3ReadOnlyAccess`.
- **Day 3** — RDS MySQL (private subnet) + secure EC2 → RDS access over 3306.
- **Day 4** — S3 policies: public read via bucket policy; scoped EC2 role policy.
- **Day 5** — Mini PHP web app reads MySQL data from RDS.

---

### Week 3 – Terraform & Infrastructure as Code
- **Day 1** — S3 bucket with Terraform (`init → plan → apply`).
- **Day 2** — Terraform EC2 with variables and outputs.
- **Day 3** — Remote state: S3 backend + DynamoDB state locking.
- **Day 4** — Custom VPC (public + private subnets) + routing.
- **Day 5** — IAM role for EC2 with S3 read-only permissions.

---

### Week 4 – Containers & Deployment
- **Day 1** — Dockerize Node “Hello World”.
- **Day 2** — Push image to DockerHub (`timuser91/myapp:1.0`).
- **Day 3** — Deploy container to AWS ECS (Fargate) + public endpoint.
- **Day 4–5** — CI/CD pipeline: GitHub Actions → DockerHub → ECS deploy.

**Architecture:**  
Browser → Public IP:8080 → ECS Service → Fargate Task → Node container

---

### Week 5 – 📊 Monitoring & Observability

- **Day 1 – CloudWatch Metrics:**  
  - Launched EC2 + Apache and stress-tested with ApacheBench (`ab`).
  - Captured CPU spike in CloudWatch metrics dashboard.

- **Day 2 – CloudWatch Logs & Insights:**  
  - Streamed Apache access logs to CloudWatch Logs.
  - Ran queries in CloudWatch Insights to find top endpoints.

- **Day 3 – CloudWatch Alarms & SNS:**  
  - Created CPU alarm (>70% for 2 min).
  - SNS topic delivered email notification when alarm triggered.

- **Day 4 – ECS Container Insights:**  
  - Enabled Container Insights on ECS cluster `myapp-cluster-mk2`.
  - Verified task-level CPU, memory, network, and storage metrics.
  - Captured container-level metric screenshots.

- **Day 5 – Documentation & Repo Polish:**  
  - Centralized screenshots and diagrams under `/docs/cloudwatch/`.
  - Updated root README with metrics, logs, and alarm sections.

---

## 🧠 Key Concepts Learned

- **IAM:** Root vs IAM users, roles, instance profiles, STS, least privilege.
- **S3:** Buckets vs objects, Block Public Access, bucket policy > ACLs.
- **EC2:** Key pairs, security groups, ephemeral IPs, IMDSv2.
- **RDS:** Private endpoints, SG→SG access, SSL connections.
- **Terraform:** Providers, state, locking, variables, remote state.
- **ECS/Fargate:** Containers, services, tasks, networking.
- **CloudWatch:** Metrics, logs, alarms, Container Insights, SNS.

---

## 📂 Repository Structure

aws-fundamentals/
├─ Scripts/
│ └─ s3_list.sh
├─ week1/
├─ week2/
├─ week3/
├─ week4/
├─ week5/
└─ docs/
└─ cloudwatch/
├─ metrics.png
├─ logs-query.png
├─ alarm-triggered.png
├─ alarm-email.png
└─ architecture.png

yaml
Copy code

---

## 📊 Metrics, Logs & Alarms

| Feature | Description | Screenshot |
|--------|------------|------------|
| Metrics | CPU spike on EC2 instance captured via CloudWatch | `docs/cloudwatch/metrics.png` |
| Logs | Apache access logs queried in CloudWatch Logs Insights | `docs/cloudwatch/logs-query.png` |
| Alarms | CPU alarm > 70% triggered SNS email | `docs/cloudwatch/alarm-triggered.png` |
| Email | SNS notification received | `docs/cloudwatch/alarm-email.png` |
| ECS | Container-level metrics (CPU, memory, network, storage) | `docs/cloudwatch/metrics.png` |

---

## 🔒 Safety & Hygiene

- No credentials committed. `.gitignore` excludes `.terraform/`, state files, `*.tfvars`, and crash logs.
- Tear down lab infrastructure when idle:  
  ```bash
  terraform destroy -auto-approve


  📜 License

MIT – free to use, learn from, and extend.


---

Would you like me to include a **small architecture diagram** (Mermaid or PNG) showing EC2 → CloudWatch → SNS → Email? That’s the one piece that would really complete the `/docs/cloudwatch/` section visually.
