resource "aws_acm_certificate" "ecs_domain_certificate" {
  domain_name       = "*.${var.ecs_domain_name}"
  validation_method = "DNS"

  tags = {
    Name = "${var.ecs_cluster_name}-Certificate"
  }
}

resource "aws_route53_record" "ecs_cert_validation_records" {
  count = length(aws_acm_certificate.ecs_domain_certificate.domain_validation_options)

  zone_id = data.aws_route53_zone.ecs_domain.zone_id
  name    = aws_acm_certificate.ecs_domain_certificate.domain_validation_options[count.index].resource_record_name
  type    = aws_acm_certificate.ecs_domain_certificate.domain_validation_options[count.index].resource_record_type
  records = [aws_acm_certificate.ecs_domain_certificate.domain_validation_options[count.index].resource_record_value]
  ttl     = 60
  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "ecs_domain_certificate_validation" {
  certificate_arn        = aws_acm_certificate.ecs_domain_certificate.arn
  validation_record_fqdns = aws_route53_record.ecs_cert_validation_records[*].fqdn
}
