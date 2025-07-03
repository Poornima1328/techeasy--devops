output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

output "instance_id" {
  value = aws_instance.web.id
}

#output "public_ip" {
 # value = aws_instance.app_ec2.public_ip
#}
