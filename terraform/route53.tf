# Route 53 resource - create DNS record
resource "aws_route53_record" "subdomain_record" {
  zone_id = var.hosted_zone_id
  name    = "arka.${var.domain_name}"
  type    = "A"
  ttl     = "60"
  records = [aws_instance.ar-strapi.public_ip]
}

