variable "common_tags" {
  default = {
    Project     = "Roboshop"
    Environment = "prod"
    Terraform   = "true"
  }

}

variable "tags" {
  default = {
    Component = "web"
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
