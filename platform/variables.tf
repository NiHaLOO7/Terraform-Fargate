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

variable "ecs_cluster_name" {
  description = "name of ecs cluster"
}

variable "internet_cidr_blocks" {
    description = "cidr block of the internet"
}

variable "ecs_domain_name" {
  description = "Domain name"
}