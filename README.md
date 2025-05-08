# Terraform-ElastiCache (Valkey Engine Module)

This Terraform module provisions an AWS ElastiCache **Valkey** (Redis-compatible) cluster using a replication group.

## 🚀 Features

- Creates an ElastiCache Replication Group for Valkey engine
- Supports multi-AZ deployments
- Configurable maintenance window, parameter group, ports
- Automatically provisions a security group
- Tags and failover support

---

## 🔧 Module Usage

```hcl
provider "aws" {
  region = "us-east-1"
}

module "valkey" {
  source                     = "./modules/terraform-aws-elasticache"
  vpc_id                     = "vpc-044eea22d279ed37f"
  name                       = "aman"
  node_type                  = "cache.t3.medium"
  engine_version             = "7.2"
  parameter_group_name       = "default.valkey7"
  port                       = 6379
  automatic_failover_enabled = true
  multi_az_enabled           = true
  apply_immediately          = true
  maintenance_window         = "sun:05:00-sun:09:00"
  subnets                    = [
    "subnet-09dbab2078fefb274",
    "subnet-0c8c4d90092ea352b",
    "subnet-03ae2dd338783d4e9",
    "subnet-015e700715be19643"
  ]
  tags = {
    Environment = "dev"
    Owner       = "Aman"
  }
}
