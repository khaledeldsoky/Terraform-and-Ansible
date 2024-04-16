# Terraform Project

Welcome to my **Terraform** project! This project automates the deployment of infrastructure on **AWS**, focusing on the setup of two **EC2** instances, each residing in different **subnets**. One instance acts as a **bastion host** while the other serves as an **application server**.

## Project Overview

- **Bastion Host**: An **EC2** instance located in the **public subnet**, facilitating secure access to other instances in the **private subnet**.
- **Application Server**: An **EC2** instance deployed in the **private subnet**, hosting the application.
- **SSH Key Management**: **Private** keys are generated using **Terraform** and securely stored in **AWS Secrets Manager**. Additionally, the option to download the **private** key locally is available for ease of access.
- **Networking**: Necessary networking configurations are established, allowing **private** instances to access the **internet** through **NAT Gateway** while maintaining security from external access. **Public** instances can communicate with the **internet** via **NAT Gateway**.
- **Workspace Management**: Utilizes **Terraform workspaces** to manage different **environments**, each with its own set of **variables** for configuration flexibility.
- **Modular Approach**: Organized the project using **modules** for better **scalability** and **maintainability**, ensuring code quality and efficiency.
- **State Storage**: **Terraform state** is stored in an **S3 bucket**, providing reliability and enabling easy recovery in case of issues.

## Getting Started

To deploy the infrastructure:

1. Make sure you have configured your **AWS credentials**.
2. **Initialize** **Terraform**: `terraform init`.
3. Select the appropriate **workspace**: `terraform workspace select <workspace_name>`.
4. Review and apply changes:

   ```bash
   terraform plan -var-file=<workspace>.tfvars
   terraform apply -var-file=<workspace>.tfvars

To destroy the infrastructure, run:

   ```bash
   terraform destroy -var-file=<workspace>.tfvars
