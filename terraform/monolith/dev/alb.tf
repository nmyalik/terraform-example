module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "7.0.0"

  name = "alb"

  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.subnets.public_subnet_ids
  security_groups = [module.sg.id]

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
      certificate_arn = aws_acm_certificate.cert.arn
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