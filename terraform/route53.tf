# Route 53 resource - create DNS record
resource "aws_route53_record" "subdomain_record" {
  zone_id = "Z06607023RJWXGXD2ZL6M"
  name    = "arka.${var.domain_name}"
  type    = "A"
  ttl     = "60"
  records = [aws_instance.ar-strapi.public_ip]
}

# Output the subdomain DNS name
output "subdomain_dns_name" {
  value = "arka.${var.domain_name}"
}
