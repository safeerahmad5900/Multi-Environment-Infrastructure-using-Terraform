# Output  - for Private IP
output "private_ip_0" {
  value = aws_instance.Webserver_Prod_1.private_ip

}
output "private_ip_1" {

  value = aws_instance.Webserver_Prod_2.private_ip
}


