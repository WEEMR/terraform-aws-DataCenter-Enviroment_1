
output "FMG_Username" {
  value = "admin"
}

output "FMG_Public_IP" {
  value = aws_eip.FMG_WAN_IP.public_ip
}

output "FortiManager_Password" {
  value = aws_instance.WRady_Terraform_FMG.id
}

output "FGT_EIP" {
  value = aws_eip.FGT_EIP.public_ip
}


output "FortiGate_Password" {
  value = aws_instance.WRady_Terraform_FGT.id
}

output "Ubuntu_WebServer_Private_IP" {
  value = aws_network_interface.Ubuntu_WebServer_eth0.private_ip
}

output "Private_Subnet_ID" {
  value = aws_subnet.Virginia_Private_Subnet_1.id
}