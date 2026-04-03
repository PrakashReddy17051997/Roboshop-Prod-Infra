variable "common_tags" {
  default = {
    Project     = "Roboshop"
    Environment = "prod"
    Terraform   = "true"
  }

}

variable "tags" {
  default = {
    Component = "cart"
  }

}

variable "project_name" {
  default = "roboshop"

}
variable "environment" {
  default = "prod"

}
variable "zone_name" {
  type    = string
  default = "learndevopswithprakash.online"

}
variable "iam_instance_profile" {
    default = "EC2_full_access_role_for_shell_script"
  
}