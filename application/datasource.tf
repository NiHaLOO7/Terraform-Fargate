data "terraform_remote_state" "platform" {
  backend = "s3"
  config = {
    region = var.region
    bucket = var.remote_state_bucket
    key = var.remote_state_key
  }
}

data "template_file" "ecs_task_defination_template" {
  template = file("task_defination.json")
  vars = {
    task_defination_name= var.ecs_service_name
    docker_image_url= var.docker_image_url
    memory= var.memory
    spring_profile= var.spring_profile
    docker_container_port= var.docker_container_port
    region= var.region
    ecs_service_name= var.ecs_service_name
  }
}