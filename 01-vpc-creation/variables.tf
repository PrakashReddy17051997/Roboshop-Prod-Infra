variable "vpc_cidr" {
  default = "10.11.0.0/16"
}
variable "common_tags" {
  default = {
    Project = "roboshop"
    Environment = "Prod"
    Terraform = "true"
  }
}

variable "vpc_tags" {
  default = {}
}

variable "project_name" {
  default = "roboshop"
}

variable "environment" {
  default = "prod"
}

variable "public_subnets_cidr" {
  default = ["10.11.1.0/24", "10.11.2.0/24"]
}

variable "private_subnets_cidr" {
  default = ["10.11.11.0/24", "10.11.12.0/24"]
}

variable "database_subnets_cidr" {
  default = ["10.11.21.0/24", "10.11.22.0/24"]
}

variable "is_peering_required" {
  default = true
}