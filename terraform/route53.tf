# Route 53 resource - create DNS record
resource "aws_route53_record" "subdomain_record" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "arka.${var.domain_name}"
  type    = "A"
  ttl     = "60"
  records = [aws_instance.ar-strapi.public_ip]
}

# Data source to fetch Route 53 hosted zone ID
data "aws_route53_zone" "main" {
  id = "Z06607023RJWXGXD2ZL6M"
  name = var.domain_name
}

# Output the subdomain DNS name
output "subdomain_dns_name" {
  value = "arka.${var.domain_name}"
}
