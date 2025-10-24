# Mastering Terraform – Beginner to Expert  
*Companion repo for the Udemy course: Mastering Terraform – Beginner to Expert*

---

## 📚 Course Companion Overview
This repository contains lab code, backend config files, and helper scripts created while following the course. It’s organized to reflect environments (dev / staging), reusable modules, and common Terraform workflows.

---

## 🔧 Repository Layout
```
├── backend-switcher.sh        # switch Terraform backend (dev ↔ staging)
├── destroy-env.sh             # destroy chosen environment
├── dev.tfbackend              # backend config: dev
├── staging.tfbackend          # backend config: staging
├── modules/                   # reusable Terraform modules (network, compute, storage...)
│   ├── network/
│   ├── compute/
│   └── storage/
├── environments/
│   ├── dev/                   # dev environment root configs
│   └── staging/               # staging environment root configs
└── README.md                  # this file
```

---

## 🚀 Quick Start
1. Clone repo:
   ```bash
   git clone https://github.com/<your-username>/<repo-name>.git
   cd <repo-name>
   ```
2. Inspect or switch backend (example):
   ```bash
   ./backend-switcher.sh
   ```
3. Initialize Terraform:
   ```bash
   terraform init
   ```
4. Apply (creates infra):
   ```bash
   terraform apply -auto-approve
   ```
5. Destroy when finished:
   ```bash
   terraform apply -destroy -auto-approve
   ```

---

## 🧩 Key Concepts Covered
- Terraform lifecycle: `init`, `plan`, `apply`, `destroy`
- Remote backends and state locking (S3/DynamoDB patterns)
- Environment separation (dev vs staging)
- Modules for DRY, reusable infra
- Variables, outputs, and workspace usage
- Best practices: state hygiene, minimal secrets in code

---

## ✅ Usage Notes & Best Practices
- Do **not** commit provider credentials or sensitive variables. Use environment variables or remote secrets manager.
- Keep backend files (`*.tfbackend`) out of public repos if they contain secrets/ARNs—prefer local placeholders or CI secrets.
- Use modules for repeatable architecture pieces and keep environment-level overrides separate (in `environments/*`).
- Test changes in `dev` before promoting to `staging`.


*Happy Terraforming!* 💚


