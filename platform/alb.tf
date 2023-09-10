resource "aws_alb" "ecs_cluster_alb" {
  name = "${var.ecs_cluster_name}-ALB"
  internal = false
  security_groups = [ aws_security_group.ecs_alb_security_group.id ]
  subnets = [ split(",", join(",", data.terraform_remote_state.infrastructure.public_subnets)) ]
#   subnets = [ for subnet in aws_subnet.public : subnet.id ]

  tags = {
    Name = "${var.ecs_cluster_name}-ALB"
  }

  depends_on = [ aws_security_group.ecs_elb_security_group ]
}

resource "aws_alb_target_group" "ecs_default_target_group" {
  name = "${var.ecs_cluster_name}-TG"
  port = 80
  protocol = "HTTP"
  vpc_id = data.terraform_remote_state.infrastructure.vpc_id

  tags = {
    Name = "${var.ecs_cluster_name}-TG"
  }
}

resource "aws_alb_listener" "ecs_alb_https_listener" {
  load_balancer_arn = aws_alb.ecs_cluster_alb.arn
  port = 443
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn = aws_acm_certificate.ecs_domain_certificate.arn
  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.ecs_default_target_group.arn
  }
  depends_on = [ aws_alb_target_group.ecs_default_target_group ]
}

resource "aws_route53_record" "ecs_load_balancer_record" {
  name = "*.${var.ecs_domain_name}"
  type = "A"
  zone_id = data.aws_route53_zone.ecs_domain.zone_id
  alias {
    evalute_target_health = false
    name = aws_alb.ecs_cluster_alb.dns_name
    zone_id = aws_alb.ecs_cluster_alb.zone_id
  }
}

