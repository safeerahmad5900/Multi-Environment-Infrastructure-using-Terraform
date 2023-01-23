# Step 1 - Public IP Address of Bastion
output "public_ip" {
  value = aws_instance.Bastion_Server.public_ip
}


output "SG_Bastion" {
  value = aws_security_group.SG_Bastion.id
}


output "privaet_IP_01" {
  value = aws_instance.Web_Server01.private_ip
}
output "privaet_IP_02" {
  value = aws_instance.Web_Server02.private_ip
}


