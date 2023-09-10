remote_state_key = "PROD/infrastructure.tfstate"
remote_state_bucket = "aws-fargate-terraform-remote-state"

// Need to buy a domain first. I bought this one for 1000 rs
ecs_domain_name = "HackSolveLearn.com"
ecs_cluster_name = "Production-ECS-Cluster"
internet_cidr_blocks = "0.0.0.0/0"

