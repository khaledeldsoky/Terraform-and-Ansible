# Terraform and Ansible Project

![ Project Diagram ](/mnt/linux/data/project/final-project/screen/screen..png)

## Overview

This project involves deploying an application on EC2 instances using Terraform and configuring them for high availability using load balancers. Additionally, Ansible is used to provision necessary resources on the EC2 instances, such as Nginx, Python, and the application itself.

### Terraform Resources

- **VPC**: Defines the network configuration, including subnets and security groups.
- **EC2 Instances**:
  - **Bastion**: A gateway for accessing the application EC2 instances, enhancing security by restricting direct access.
  - **Application**: Hosts the application code and other dependencies.
- **RDS**: Sets up the database instance and configures security groups and subnets.
- **Load Balancer**: Ensures high availability by distributing traffic among multiple EC2 instances.
- **Auto Scaling**: Automatically adjusts the number of EC2 instances based on traffic load, enhancing scalability.

### Ansible Configuration

Ansible is used to provision resources on the EC2 instances, including Nginx for proxying, Python, and cloning and running the application.

### Bash Scripts

Small bash scripts are utilized to extract information from Terraform outputs and copy it to other locations.

## Getting Started

To deploy the project:

1. Clone this repository.
2. Navigate to the Terraform directory and execute `terraform init` to initialize Terraform.
3. Use `terraform apply --var-file dev.tfvars` to apply the Terraform configuration and create the infrastructure.
4. Once the infrastructure is created, navigate to the Ansible directory and execute the necessary Ansible playbooks to provision the EC2 instances.
5. Verify that the application is running successfully.

## Contributing

If you have any questions, suggestions, or corrections, feel free to contribute to the project. Your feedback is highly appreciated!
