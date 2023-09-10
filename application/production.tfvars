remote_state_key = "PROD/platform.tfstate"
remote_state_bucket = "aws-fargate-terraform-remote-state"


ecs_service_name = "springbootapp"
# docker_image_url = "" provided after new image is pushed through the pipeline
memory = 1024
docker_container_port = 8080
spring_profile = "default"
desired_task_number = 2
