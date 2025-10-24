# Mastering Terraform – From Beginner to Expert
*Repository of labs, exercises & projects from the Udemy course*

## 📘 Course overview
This repository contains the hands‑on code, labs, and project work from the Udemy course *Mastering Terraform: From Beginner to Expert*. This course covers 20+ hours of content, more than 60 practical labs, and 5‑6 real‑world AWS projects.

### What you will learn
- How to use Terraform to implement Infrastructure as Code (IaC)
- Proficiency with Terraform providers, backends, state, modules, workspaces, variables and outputs
- Hands‑on AWS resource provisioning: EC2, S3, IAM, RDS etc.
- Preparing for the HashiCorp Certified: Terraform Associate certification

### Prerequisites
- Basic AWS knowledge recommended
- Basic Git / GitHub familiarity
- No prior Terraform experience required

## 📁 Repository structure
```
/exercises         ← step‐by‐step labs from the course
/projects          ← full projects with real‐world use‑cases
/modules           ← reusable Terraform modules created during the course
/examples          ← demo snippets and sample configurations
README.md          ← this file
```
> *Feel free to adjust folder names based on how you structure your code.*

## 🚀 Getting started
1. Clone this repository to your local machine.
   ```bash
   git clone https://github.com/krdungca/terraform‑course.git
   ```
2. Navigate into the relevant directory (exercise or project).
3. Configure your AWS credentials.
4. Initialize Terraform, plan and apply:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```
5. After you’re done, cleanup:
   ```bash
   terraform destroy
   ```

## 🧠 Course milestones
- Introduction to Infrastructure as Code (IaC)
- HashiCorp Configuration Language (HCL) basics
- Providers & resources
- Data sources, expressions & functions
- Input variables, locals, outputs
- State management, remote backends
- Workspaces & environment‑separation
- Terraform Modules
- Importing existing infrastructure
- Terraform Cloud / Terraform Enterprise integration
- Real‑world AWS projects

## ✅ Why this course / repo matters
- Hands‑on lab‑based — you learn by doing.
- Covers both theory and real AWS infrastructure.
- Great preparation for Terraform certification and DevOps roles.
- This repo acts as your “playground” and reference.

## 📚 Additional resources
- [Terraform Documentation](https://www.terraform.io/docs)
- [Terraform Associate Exam Guide](https://developer.hashicorp.com/certifications/terraform-associate)
- [Terraform Registry](https://registry.terraform.io/)
- [AWS Well‑Architected Framework](https://aws.amazon.com/architecture/well-architected/)

## 📝 Notes / Tips
- Always run `terraform plan` before `apply`.
- Use remote backends (S3 + DynamoDB) for team setups.
- Keep modules reusable and versioned.
- Separate environments with workspaces or folders.

---

> *This repository is for educational purposes. Please clean up AWS resources to avoid costs.*

---

## ✍️ Contribution 
Feel free to fork the repo, add exercises or modules, or create pull requests

---

Happy Terraforming! 🏗️

