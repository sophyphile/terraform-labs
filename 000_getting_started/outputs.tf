output "instance_ip_addr" {
  value = aws_instance.sami_server.public_ip
}
