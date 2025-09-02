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
- **Day 1** — **Terraform: first S3 bucket** (`week3/day1/`).
  - Steps: `init → fmt → validate → plan → apply`.
  - Output `bucket_name`: *(see `terraform output -raw bucket_name` in README inside day folder)*.
  - Notes: local state (`terraform.tfstate`, gitignored); region **ap-southeast-2**.

## Key Concepts Learned
- **IAM:** root vs users, groups, MFA; **roles vs users**, instance profiles; STS temp creds; least privilege.
- **S3:** buckets vs objects; Block Public Access; **bucket policy > ACLs**; virtual-hosted–style URLs.
- **EC2:** key pairs; security groups; ephemeral public IP; **IMDSv2 required**.
- **RDS:** private endpoints; SG→SG; SSL client connections.
- **Terraform:** providers, lockfile, state, `plan/apply/destroy`, `random_id` for unique names; keep state & `.terraform/` out of Git.

## Repository Structure
aws-fundamentals/
├─ Scripts/
│ └─ s3_list.sh
├─ week1/
│ ├─ day1/ ├─ day2/ ├─ day3/ └─ day4/
├─ week2/
│ ├─ day1-ec2/
│ ├─ day2-iam-role-s3-readonly/
│ ├─ day3-rds/
│ └─ day4-s3-policy-public-read/
├─ week3/
│ └─ day1/
├─ mini-app/
└─ README.md


## Safety & Hygiene
- No credentials in repo. `.gitignore` includes: `.terraform/`, `terraform.tfstate`, `terraform.tfstate.backup`, `*.tfvars`, `crash.log`.
- Tear down lab infra when idle: `terraform destroy -auto-approve`.

## Anki (selected)
- Initialize Terraform project → `terraform init`
- What file stores Terraform state? → `terraform.tfstate`
- What does `terraform plan` do? → Shows the execution plan without changing resources.
