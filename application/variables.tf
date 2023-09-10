variable "region" {
  default="eu-west-1"
  description = "region of aws"
}

variable "remote_state_bucket" {
  description = "remote state bucket"
}

variable "remote_state_key" {
  description = "remote state key"
}


// Task Defination variables
variable "ecs_service_name" {
  description = "service name of the ecs"
}

// Provide on plan and apply command
// From the pipeline maybe
variable "docker_image_url" {}


variable "memory" {}
variable "docker_container_port" {}
variable "spring_profile" {}

// Service
variable "desired_task_number" {}

