variable "vpc_cidr" {
  default = "10.0.0.0/16"
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
  default = ["10.10.1.0/16", "10.10.2.0/16"]
}

variable "private_subnets_cidr" {
  default = ["10.10.11.0/16", "10.10.12.0/16"]
}

variable "database_subnets_cidr" {
  default = ["10.10.21.0/16", "10.10.22.0/16"]
}

variable "is_peering_required" {
  default = true
}