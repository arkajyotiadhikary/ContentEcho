output "instance_id" {
  value = aws_instance.strapi.id
}

output "public_ip" {
  value = aws_instance.strapi.public_ip
}
