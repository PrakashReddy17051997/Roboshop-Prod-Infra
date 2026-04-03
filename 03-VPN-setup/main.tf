module "vpn" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name                   = "${local.ec2_name}-vpn"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  subnet_id              = data.aws_subnet.selected.id
  create_security_group  = false
  user_data = file("openvpn.sh")
  tags = merge(
    var.common_tags,
    {
      Component = "vpn"
    },
    {
      Name = "${local.ec2_name}-vpn"
    }
  )


}
resource "null_resource" "download_ovpn" {
  triggers = {
    instance_id = module.vpn.id
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "Waiting 60s for file to be ready..."
      sleep 240
      
      echo "Downloading via password authentication..."
      sshpass -p 'DevOps321' scp -o StrictHostKeyChecking=no \
          centos@${module.vpn.public_ip}:/home/centos/Prakash.ovpn ${path.module}/Prakash.ovpn
    EOT
  }
}