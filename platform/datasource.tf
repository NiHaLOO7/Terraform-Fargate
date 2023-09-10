data "terraform_remote_state" "infrastructure" {
  backend = "s3"
  config = {
    region = var.region
    bucket = var.remote_state_bucket
    key = var.remote_state_key
  }
}

data "aws_route53_zone" "ecs_domain" {
  name = var.ecs_domain_name
  private_zone = false
}
