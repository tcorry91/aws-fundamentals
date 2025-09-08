# aws-fundamentals
Hands-on AWS & Terraform labs on Windows (PowerShell + Git Bash). Real outputs (screenshots, commands, notes).

## Overview
Week-by-week labs covering IAM, EC2, S3, RDS, and Terraform. Emphasis on least privilege, instance roles, and reproducible infra.

## Completed Labs
### Week 1
- **Day 1** — Account + AWS CLI setup; verified with `aws s3 ls` (`week1/day1/`).
- **Day 2** — EC2 (Amazon Linux/Ubuntu): launch, SSH, web server, security groups (`week1/day2/`).
- **Day 3** — IAM users, groups, MFA; least privilege (`week1/day3/`).
- **Day 4** — S3 static website hosting; bucket policy + index (`week1/day4/`).
- **Day 5** — Bash script to list S3 buckets → `s3_report.txt` (`Scripts/s3_list.sh`).

### Week 2
- **Day 1** — EC2 lifecycle (stop/start/reboot/terminate) + Apache hello (`week2/day1-ec2/`).
- **Day 2** — **EC2 instance role** with `AmazonS3ReadOnlyAccess`; verified `assumed-role/...` and denied PutObject (`week2/day2-iam-role-s3-readonly/`).
- **Day 3** — **RDS MySQL** (`db.t3.micro`, private): SG→SG (EC2→RDS:3306), SSL client, table + row, persistence check (`week2/day3-rds/`).
- **Day 4** — **S3 policies**: public object READ via bucket policy; EC2 role inline policy for bucket-scoped Put/List; verified public URL (`week2/day4-s3-policy-public-read/`).
- **Day 5** — **Mini app (EC2+RDS)**: PHP reads `testdb.users` over HTTP (`mini-app/`).

### Week 3
- **Day 1** — **Terraform: first S3 bucket** (`Week 3/day1/`).
  - Steps: `init → fmt → validate → plan → apply`.
  - Output `bucket_name`: *(see `terraform output -raw bucket_name` in the day folder)*.
  - Notes: local state (`terraform.tfstate`, gitignored); region **ap-southeast-2**.
- **Day 2** — **Terraform: EC2 via variables + outputs** (`Week 3/day2/`).
  - Vars: `instance_type` (t3.micro), `key_name` (tim-w3d2-console), `ami_id` (optional), `ingress_cidr` (lab: 0.0.0.0/0).
  - Steps: `init → fmt → validate → apply → ssh → echo 'IaC works!' > /var/www/html/index.html`.
  - Outputs: `public_ip`, `public_dns`. Screenshots: `w3d2-apply-outputs.png`, `w3d2-ssh-echo.png`, `w3d2-http-iac-works.png`.
- **Day 3** — **Remote state (S3 + DynamoDB lock)** (`Week 3/day2/` state migrated)
  - Bucket: **terraform-state-2025-568438991403**  
  - Key: **Week 3/day2/terraform.tfstate**  
  - Region: **ap-southeast-2**; Lock table: **tf-locks**  
  - Why remote state: centralized, durable, versioned state; team-safe with locking; avoids local loss/corruption.  
  - State lock: a DynamoDB record that prevents concurrent writes.
- **Day 4** — **Custom VPC (public + private)** (`Week 3/day4/`)
  - VPC `10.0.0.0/16`; Public `10.0.1.0/24` (0.0.0.0/0 → IGW); Private `10.0.2.0/24` (local only).
  - Diagram:
    ```mermaid
    flowchart TB
      igw[Internet Gateway]
      subgraph VPC[ VPC 10.0.0.0/16 ]
        pub[Public Subnet 10.0.1.0/24]
        priv[Private Subnet 10.0.2.0/24]
        rt_pub[Public RT: 0.0.0.0/0 -> IGW]
        rt_priv[Private RT: local only]
      end
      pub --> rt_pub --> igw
      priv --> rt_priv
    ```
- **Day 5** — **IAM role for EC2 (S3 read-only)** (`Week 3/day5/`)
  - Role: `EC2S3Role` (trust = EC2) + AWS managed `AmazonS3ReadOnlyAccess`.
  - Instance profile attached at launch; `aws sts get-caller-identity` shows `assumed-role/EC2S3Role/...`; `aws s3 ls` succeeds.

### Week 4

- **Day 1** - cloud-ci-cd-demo — Dockerized Node “Hello World”
Simple Node.js app containerized with Docker.



## Key Concepts Learned
- **IAM:** root vs users, groups, MFA; **roles vs users**, instance profiles; STS temp creds; least privilege.
- **S3:** buckets vs objects; Block Public Access; **bucket policy > ACLs**; virtual-hosted–style URLs.
- **EC2:** key pairs; security groups; ephemeral public IP; **IMDSv2 required**.
- **RDS:** private endpoints; SG→SG; SSL client connections.
- **Terraform:** providers, lockfile, state, `plan/apply/destroy`, `random_id` for unique names; keep state & `.terraform/` out of Git.
- **Remote State:** S3 backend + DynamoDB state locking.

## Repository Structure
aws-fundamentals/
├─ Scripts/
│  └─ s3_list.sh
├─ week1/
│  ├─ day1/ ├─ day2/ ├─ day3/ └─ day4/
├─ week2/
│  ├─ day1-ec2/
│  ├─ day2-iam-role-s3-readonly/
│  ├─ day3-rds/
│  └─ day4-s3-policy-public-read/
├─ Week 3/
│  ├─ day1/
│  ├─ day2/
│  ├─ day3/
│  ├─ day4/
│  └─ day5/
├─ Week 4/
│  ├─ day1/
└─ README.md

## Safety & Hygiene
- No credentials in repo. `.gitignore` includes: `.terraform/`, `terraform.tfstate`, `terraform.tfstate.backup`, `*.tfvars`, `crash.log`.
- Tear down lab infra when idle: `terraform destroy -auto-approve`.
