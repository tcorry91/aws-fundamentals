aws-fundamentals

Hands-on AWS & Terraform labs on Windows (PowerShell + Git Bash). Real outputs: screenshots, commands, and notes from building infrastructure step by step.

Overview

A full progression from AWS fundamentals to production-grade cloud infrastructure. Covers IAM, EC2, S3, RDS, Terraform, Docker, ECS Fargate, and CloudWatch — with emphasis on least privilege, automation, observability, and reproducible infrastructure.

Completed Labs
Week 1 – Core AWS Basics

Day 1 — AWS account setup + AWS CLI verification (aws s3 ls)

Day 2 — Launch EC2, SSH access, security groups, and web server

Day 3 — IAM users, groups, MFA, and least privilege

Day 4 — S3 static website hosting and bucket policies

Day 5 — Bash script to list S3 buckets → s3_report.txt

Week 2 – Roles, RDS, and Policies

Day 1 — EC2 lifecycle operations (stop/start/reboot/terminate)

Day 2 — EC2 instance role with AmazonS3ReadOnlyAccess

Day 3 — RDS MySQL (private subnet) + secure EC2 → RDS access over 3306

Day 4 — S3 policies: public read via bucket policy; scoped EC2 role policy

Day 5 — Mini PHP web app reads MySQL data from RDS

Week 3 – Terraform & Infrastructure as Code

Day 1 — S3 bucket with Terraform (init → plan → apply)

Day 2 — Terraform EC2 with variables and outputs

Day 3 — Remote state: S3 backend + DynamoDB state locking

Day 4 — Custom VPC (public + private subnets) + routing

Day 5 — IAM role for EC2 with S3 read-only permissions

Week 4 – Containers & Deployment

Day 1 — Dockerize Node “Hello World”

Day 2 — Push image to DockerHub (timuser91/myapp:1.0)

Day 3 — Deploy container to AWS ECS (Fargate) + public endpoint

Day 4–5 — CI/CD pipeline: GitHub Actions → DockerHub → ECS deploy

Architecture:
Browser → Public IP:8080 → ECS Service → Fargate Task → Node container

Week 5 – Monitoring & Observability

Day 1 – CloudWatch Metrics:
Launched EC2 + Apache, stress-tested with ApacheBench (ab), and captured CPU spike in CloudWatch.

Day 2 – CloudWatch Logs & Insights:
Streamed Apache access logs to CloudWatch Logs and queried top endpoints.

Day 3 – CloudWatch Alarms & SNS:
Created a CPU alarm (>70% for 2 min) and received SNS email notifications.

Day 4 – ECS Container Insights:
Enabled Container Insights on ECS cluster myapp-cluster-mk2 and verified task-level metrics (CPU, memory, network, storage).

Day 5 – Documentation & Repo Polish:
Centralized screenshots and diagrams under /docs/cloudwatch/ and updated the README.

Week 6 – Portfolio Polish & Final Assembly

Fundamentals Repo: Cleaned screenshots, removed clutter, and added a “Lessons Learned” section.

Core Services Repo: Verified mini PHP app (EC2 → RDS → S3) and added a full setup guide.

Terraform Repo: Added USAGE.md with init/plan/apply/destroy workflow and VPC architecture diagram.

CI/CD Repo: Verified GitHub Actions → DockerHub → ECS pipeline end-to-end and added a pipeline diagram.

Monitoring Repo: Added alarm → SNS diagram and embedded screenshots directly in the README.

Capstone Project: Created cloud-capstone-project combining Terraform infra, Dockerized app, ECS deployment, and CloudWatch monitoring.

Result: All repos are now polished, documented, and portfolio-ready — with architecture diagrams, installation instructions, and real outputs.

Key Concepts Learned

IAM: Root vs IAM users, roles, instance profiles, STS, least privilege

S3: Buckets vs objects, Block Public Access, bucket policy > ACLs

EC2: Key pairs, security groups, ephemeral IPs, IMDSv2

RDS: Private endpoints, SG→SG access, SSL connections

Terraform: Providers, state, locking, variables, remote state

ECS/Fargate: Containers, services, tasks, networking

CloudWatch: Metrics, logs, alarms, Container Insights, SNS

Repository Structure
aws-fundamentals/
├─ Scripts/
│  └─ s3_list.sh
├─ week1/
├─ week2/
├─ week3/
├─ week4/
├─ week5/
├─ docs/
│  ├─ architecture-diagram.png
│  ├─ pipeline-diagram.png
│  └─ cloudwatch/
│     ├─ metrics.png
│     ├─ logs-query.png
│     ├─ alarm-triggered.png
│     ├─ alarm-email.png
│     └─ ecs-container-insights.png

Metrics, Logs & Alarms
Feature	Description	Screenshot
Metrics	CPU spike on EC2 instance captured via CloudWatch	docs/cloudwatch/metrics.png
Logs	Apache access logs queried in CloudWatch Logs Insights	docs/cloudwatch/logs-query.png
Alarms	CPU alarm > 70% triggered SNS email	docs/cloudwatch/alarm-triggered.png
Email	SNS notification received	docs/cloudwatch/alarm-email.png
ECS	Container-level metrics (CPU, memory, network, storage)	docs/cloudwatch/ecs-container-insights.png
Installation & Setup

Steps to deploy the sample PHP app that connects EC2 → RDS → S3:

1. Clone this repo
git clone https://github.com/<your-username>/aws-fundamentals.git
cd aws-fundamentals

2. Launch an EC2 instance

Use Amazon Linux 2023 (t3.micro is fine)

Open inbound ports: 22 (SSH) and 80 (HTTP)

Attach an IAM role with AmazonS3ReadOnlyAccess

Connect to the instance:

ssh -i your-key.pem ec2-user@<public-ip>

3. Install Apache + PHP
sudo dnf install -y httpd php php-mysqlnd
sudo systemctl enable --now httpd

4. Deploy the app

Copy the PHP app to the web root:

sudo cp app/index.php /var/www/html/index.php


Edit index.php with your RDS connection info:

$host = "your-rds-endpoint.amazonaws.com";
$user = "admin";
$pass = "password";
$db   = "testdb";


Restart Apache:

sudo systemctl restart httpd

5. Verify everything

Ensure RDS SG allows 3306 from EC2 SG

Create an S3 bucket and upload a test object

Access the app:

http://<EC2-public-ip>


You should see "It works!" and database data.

This is a minimal setup for learning and demos — not production-ready. Extend with load balancers, HTTPS, and private subnets for real-world use.

Safety & Hygiene

No credentials committed. .gitignore excludes .terraform/, state files, *.tfvars, and crash logs.

Tear down lab infrastructure when idle:

terraform destroy -auto-approve

License

MIT — free to use, learn from, and extend.