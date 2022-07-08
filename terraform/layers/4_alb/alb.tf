module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "7.0.0"

  name = "alb"

  load_balancer_type = "application"

  vpc_id          = data.terraform_remote_state.vpc.outputs.vpc_id
  subnets         = data.terraform_remote_state.sg.outputs.public_subnet_ids
  security_groups = [data.terraform_remote_state.sg.outputs.id]

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTPS"
      backend_port     = 443
      target_type      = "instance"
    }
  ]

  https_listeners = [
    {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = data.terraform_remote_state.dns.outputs.cert_arn
    }
  ]

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

  tags = {
    Environment = var.env
  }
}

resource "aws_route53_record" "domain_wilcard" {
  zone_id = data.terraform_remote_state.dns.outputs.zone_id
  name    = "*"
  type    = "CNAME"
  ttl     = "5"
  records = [module.alb.lb_dns_name]
}
