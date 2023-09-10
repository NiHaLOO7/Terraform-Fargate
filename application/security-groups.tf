resource "aws_security_group" "app_security_group" {
  name = "${var.ecs_service_name}-SG"
  description = "Security Group for Application to communicate in and out"
  vpc_id = data.terraform_remote_state.platform.vpc_id
  ingress = {
    from_port= 8080
    protocol= "TCP"
    to_port= 8080
    cidr_blocks= [ data.terraform_remote_state.platform.vpc_cidr_block ]
  }

  egress = {
    from_port= 0
    protocol= "-1"
    to_port= 0
    cidr_blocks= [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "${var.ecs_service_name}-SG"
  }
}