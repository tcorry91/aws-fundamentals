## Mini App (EC2 + RDS)

Apache+PHP app on EC2 queries RDS MySQL (`testdb.users`) and prints rows.

**Network**
- Same VPC as EC2.
- RDS SG inbound: MySQL/Aurora 3306 **from EC2’s SG** (SG→SG).
- DB is **not publicly accessible**.

**Deploy (on EC2)**
1) Install: `sudo dnf -y install httpd php php-mysqlnd && sudo systemctl enable --now httpd`
2) Copy `index.php` to `/var/www/html/index.php`.
3) Replace `RDS_ENDPOINT_HERE` with your RDS endpoint and `CHANGE_ME` with the DB password.
4) `sudo systemctl restart httpd`
5) Test: `curl http://127.0.0.1/` → should show `users:` with a row.

**DB init**
`mysql -h <endpoint> -u admin -p --ssl-mode=REQUIRED < schema.sql`

**Notes**
- Don’t commit real secrets. Use placeholders in Git.
- Tear down when done to avoid costs (terminate EC2, delete RDS).
