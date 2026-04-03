module "mongodb" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami                    = data.aws_ami.centos8.id
  name                   = "${local.ec2_name}-mongodb"
  instance_type          = "t3.small"
  create_security_group  = false
  vpc_security_group_ids = [data.aws_ssm_parameter.mongodb_sg_id.value]
  subnet_id              = local.database_subnet_id
  tags = merge(
    var.common_tags,
    {
      component = "mongodb"
    },
    {
      Name = "${local.ec2_name}-mongodb"
    }
  )
}



resource "null_resource" "mongodb" {
    triggers = {
      instance_id = module.mongodb.id
    }

    connection {
      host = module.mongodb.private_ip
      type = "ssh"
      user = "centos"
      password = "DevOps321"
    }

    provisioner "file" {
        source = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
      
    }
    provisioner "remote-exec" {

        inline = [ 
            "chmod +x /tmp/bootstrap.sh",
            "sudo sh /tmp/bootstrap.sh mongodb ${var.environment}"
         ]
      
    }
}

resource "aws_route53_record" "mongodb" {
    zone_id =data.aws_route53_zone.selected.zone_id
    allow_overwrite = true
    name = "mongodb" 
    
    type = "A"
    ttl = 1
    records = ["${module.mongodb.private_ip}"]
  
}


module "redis" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami                    = data.aws_ami.centos8.id
  name                   = "${local.ec2_name}-redis"
  instance_type          = "t2.micro"
  create_security_group  = false
  vpc_security_group_ids = [data.aws_ssm_parameter.redis_sg_id.value]
  subnet_id              = local.database_subnet_id
  tags = merge(
    var.common_tags,
    {
      component = "redis"
    },
    {
      Name = "${local.ec2_name}-redis"
    }
  )
}



resource "null_resource" "redis" {
    triggers = {
      instance_id = module.redis.id
    }

    connection {
      host = module.redis.private_ip
      type = "ssh"
      user = "centos"
      password = "DevOps321"
    }

    provisioner "file" {
        source = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
      
    }
    provisioner "remote-exec" {

        inline = [ 
            "chmod +x /tmp/bootstrap.sh",
            "sudo sh /tmp/bootstrap.sh redis ${var.environment}"
         ]
      
    }
}

resource "aws_route53_record" "redis" {
    zone_id =data.aws_route53_zone.selected.zone_id
    allow_overwrite = true
    name = "redis" 
    
    type = "A"
    ttl = 1
    records = ["${module.mongodb.private_ip}"]
  
}

module "mysql" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami                    = data.aws_ami.centos8.id
  name                   = "${local.ec2_name}-mysql"
  instance_type          = "t3.small"
  create_security_group  = false
  vpc_security_group_ids = [data.aws_ssm_parameter.mysql_sg_id.value]
  subnet_id              = local.database_subnet_id
  iam_instance_profile = "EC2_full_access_role_for_shell_script"
  tags = merge(
    var.common_tags,
    {
      component = "mysql"
    },
    {
      Name = "${local.ec2_name}-mysql"
    }
  )
}



resource "null_resource" "mysql" {
    triggers = {
      instance_id = module.mysql.id
    }

    connection {
      host = module.mysql.private_ip
      type = "ssh"
      user = "centos"
      password = "DevOps321"
    }

    provisioner "file" {
        source = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
      
    }
    provisioner "remote-exec" {

        inline = [ 
            "chmod +x /tmp/bootstrap.sh",
            "sudo sh /tmp/bootstrap.sh mysql ${var.environment}"
         ]
      
    }
}

resource "aws_route53_record" "mysql" {
    zone_id =data.aws_route53_zone.selected.zone_id
    allow_overwrite = true
    name = "mysql" 
    
    type = "A"
    ttl = 1
    records = ["${module.mysql.private_ip}"]
  
}

module "rabbitmq" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami                    = data.aws_ami.centos8.id
  name                   = "${local.ec2_name}-rabbitmq"
  instance_type          = "t2.micro"
  create_security_group  = false
  vpc_security_group_ids = [data.aws_ssm_parameter.rabbitmq_sg_id.value]
  subnet_id              = local.database_subnet_id
  iam_instance_profile = "EC2_full_access_role_for_shell_script"
  tags = merge(
    var.common_tags,
    {
      component = "rabbitmq"
    },
    {
      Name = "${local.ec2_name}-rabbitmq"
    }
  )
}



resource "null_resource" "rabbitmq" {
    triggers = {
      instance_id = module.rabbitmq.id
    }

    connection {
      host = module.rabbitmq.private_ip
      type = "ssh"
      user = "centos"
      password = "DevOps321"
    }

    provisioner "file" {
        source = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
      
    }
    provisioner "remote-exec" {

        inline = [ 
            "chmod +x /tmp/bootstrap.sh",
            "sudo sh /tmp/bootstrap.sh rabbitmq ${var.environment}"
         ]
      
    }
}

resource "aws_route53_record" "rabbitmq" {
    zone_id =data.aws_route53_zone.selected.zone_id
    allow_overwrite = true
    name = "rabbitmq" 
    
    type = "A"
    ttl = 1
    records = ["${module.rabbitmq.private_ip}"]
  
}