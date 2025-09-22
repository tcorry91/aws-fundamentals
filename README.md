### Week 4

- **Day 1** — Dockerize Node “Hello World” (`cloud-ci-cd-demo/`):  
  `docker build -t myapp:1.0 .` → `docker run -p 8080:8080 myapp:1.0` (screenshots in `Screenshots/`).

- **Day 2** — **Docker Hub push** (`cloud-ci-cd-demo/`).  
  - Tagged & pushed: `timuser91/myapp:1.0`  
  - Commands:  
    ```bash
    docker login -u timuser91
    docker tag myapp:1.0 timuser91/myapp:1.0
    docker push timuser91/myapp:1.0
    ```  
  - Proof: `Screenshots/day2-push-success.png` (digest shown), `Screenshots/day2-hub-tags.png` (Hub repo/tag visible)

- **Day 3** — **Run container on AWS ECS (Fargate)**  
  **Goal:** Deploy DockerHub image `timuser91/myapp:1.0` onto AWS ECS Fargate and make it accessible via a public endpoint.  
  **Steps:**  
  1. Created Fargate task definition `myapp-task` with container port **8080/TCP**.  
  2. Created ECS cluster `myapp-cluster-mk2`.  
  3. Created ECS service `myapp-svc`:  
     - Launch type: Fargate (0.25 vCPU / 0.5 GB)  
     - Subnets: **public**  
     - Public IP: **enabled**  
     - Security group: inbound **TCP 8080** from `0.0.0.0/0`  
  4. Waited for task → **Running**.  
  5. Copied Public IP → hit in browser.  

  **Architecture:**  
  Browser → Public IP:8080 → ECS Service → Fargate Task → Node container  

  **Proof:**  
  - ECS task details (Running, Public IP visible)  

- **Day 4–5** — **CI/CD Pipeline: GitHub Actions → DockerHub → ECS Deploy**  
  **Goal:** Fully automated pipeline from commit → live app.  

  **Pipeline:**  
  1. Developer commits → pushes to `main`.  
  2. GitHub Actions workflow triggers:  
     - Checkout → build image (`app/Dockerfile`)  
     - Tag with `1.1` and commit SHA  
     - Push to **DockerHub**  
     - Register new ECS task definition  
     - Update ECS service → deploy new revision  
  3. ECS pulls new Docker image and redeploys automatically.  
  4. Browser shows updated app message from new container.  

  **Diagram:**  
  ```mermaid
  flowchart LR
    Dev[Developer Commit] --> GH[GitHub Actions]
    GH --> DH[DockerHub Registry]
    GH --> ECS[AWS ECS Service]
    ECS --> User[User Browser]
