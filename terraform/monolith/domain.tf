resource "aws_route53_zone" "root_zone" {
  name = var.root_zone

  tags = {
    Environment = var.env
  }
}

resource "aws_route53_record" "domain_wilcard" {
  zone_id = aws_route53_zone.root_zone.zone_id
  name    = "*"
  type    = "CNAME"
  ttl     = "5"
  records = [module.alb.lb_dns_name]
}

resource "aws_acm_certificate" "cert" {
  domain_name       = "*.${var.root_zone}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}