output "default_vpc_id" {
  description = "Default VPC ID used by this stack."
  value       = data.aws_vpc.default.id
}

output "subnet_id" {
  description = "Default subnet selected for the EC2 instance."
  value       = aws_instance.nginx_server.subnet_id
}

output "security_group_id" {
  description = "Security group attached to the EC2 instance."
  value       = aws_security_group.nginx_sg.id
}

output "instance_id" {
  description = "EC2 instance ID."
  value       = aws_instance.nginx_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the Nginx EC2 instance."
  value       = aws_instance.nginx_server.public_ip
}

output "instance_public_dns" {
  description = "Public DNS of the Nginx EC2 instance."
  value       = aws_instance.nginx_server.public_dns
}

output "nginx_url" {
  description = "Nginx URL."
  value       = "http://${aws_instance.nginx_server.public_ip}"
}
