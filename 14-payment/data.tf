

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/private_subnet_ids"
}

data "aws_ssm_parameter" "app_alb_sg_id"{
  name = "/${var.project_name}/${var.environment}/app_alb_sg_id"
}

data "aws_ssm_parameter" "vpc_id"{
  name = "/${var.project_name}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "payment_sg_id"{
  name = "/${var.project_name}/${var.environment}/payment_sg_id"
}

data "aws_ssm_parameter" "ec2_instance_username"{
  name = "/${var.project_name}/${var.environment}/ec2_instance_username"
}
data "aws_ssm_parameter" "ec2_instance_password"{
  name = "/${var.project_name}/${var.environment}/ec2_instance_password"
}
data "aws_route53_zone" "selected" {
  name = var.zone_name
  private_zone = false
  
}

data "aws_ssm_parameter" "app_alb_listener_arn"{
  name = "/${var.project_name}/${var.environment}/app_alb_listener_arn"
}