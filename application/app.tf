resource "aws_ecs_task_definition" "springbootapp-task-defination" {
  container_definitions = data.template_file.ecs_task_defination_template.rendered
  family = var.ecs_service_name
  cpu = 512
  memory = var.memory
  requires_compatibilities = [ "FARGATE" ]
  network_mode = "awsvpc"
  execution_role_arn = aws_iam_role.fargate_iam_role.arn
  task_role_arn = aws_iam_role.fargate_iam_role.arn

}

resource "aws_alb_target_group" "ecs_app_target_group" {
  name= "${var.ecs_service_name}-TG"
  port = var.docker_container_port
  protocol = "HTTP"
  vpc_id = data.terraform_remote_state.platform.vpc_id
  target_type = "ip"

  health_check {
    path = "/actuator/health"
    protocol = "HTTP"
    matcher = "200"
    interval = 60
    timeout = 30
    unhealthy_threshold = 3
    healthy_threshold = 3
  }

  tags = {
    Name = "${var.ecs_service_name}-TG"
  }
}

resource "aws_ecs_service" "ecs_service" {
  name = var.ecs_service_name
  task_definition = var.ecs_service_name
  desired_count = var.desired_task_number
  cluster = data.terraform_remote_state.platform.ecs_cluster_name
  launch_type = "FARGATE"

  network_configuration {
    subnets = [ data.terraform_remote_state.platform.ecs_public_subnets ]
    security_groups = [ aws_security_group.app_security_group.id ]
    assign_public_ip = true
  }

  load_balancer {
    container_name = var.ecs_service_name
    container_port = var.docker_container_port
    target_group_arn = aws_alb_target_group.ecs_app_target_group.arn
  }
}

resource "aws_alb_listener_rule" "ecs_alb_listner_rule" {
  listener_arn = data.terraform_remote_state.platform.ecs_alb_istener_arn
  action {
    type = "forward"
    target_group_arn = aws_alb_target_group.ecs_app_target_group.arn
  }
  condition {
    field = "host-header"
    value = ["${lower(var.ecs_service_name)}.${data.terraform_remote_state.platform.ecs_domain_name}"]
  }

}

