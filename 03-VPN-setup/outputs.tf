output "vpc_id_vpn_selected_subnet" {
  value = data.aws_subnet.selected.id
}

output "subnet_id" {
  value = data.aws_subnet.selected.id
  
}

output "vpn_module" {
  value = module.vpn
  
}