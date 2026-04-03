variable "common_tags" {
    default = {
        Project = "Roboshop"
        Environment = "dev"
        Terraform = "true"
    }
  
}


variable "project_name" {
    default = "roboshop"
  
}
variable "environment" {
    default = "dev"
  
}
variable "private_key_path" {
    default = "/Users/orakanti1997/Documents/DevOps/"
  
}