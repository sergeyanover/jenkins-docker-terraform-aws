output "ec2_public_ip" {
  value = aws_instance.dev_jenkins.public_ip
}