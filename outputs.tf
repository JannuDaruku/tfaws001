output "instance_id" {
  description = " id of created instances. "
  value = aws_instance.instance.id
}

output "private_ip" {
  description = "Private IPs of created instances. "
  value = aws_instance.instance.private_ip
}

output "public_ip" {
  description = "Public IPs of created instances. "
  value = aws_instance.instance.public_ip
}
