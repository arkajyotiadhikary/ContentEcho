output "instance_id" {
  value = aws_instance.ar-strapi[0].id
}

output "public_ip" {
  value = aws_instance.ar-strapi[0].public_ip
}

