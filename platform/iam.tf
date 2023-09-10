resource "aws_iam_role" "ecs_cluster_role" {
  name = "${var.ecs_cluster_name}-IAM-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = [
            "ecs.amazonaws.com",
            "ec2.amazonaws.com",
            "application-autoscaling.amazonaws.com",
          ]
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "ecs_cluster_policy" {
  name = "${var.ecs_cluster_name}-IAM-Policy"
  role = aws_iam_role.ecs_cluster_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ecs:*",
          "ec2:*",
          "elasticloadbalancing:*",
          "ecr:*",
          "dynamodb:*",
          "cloudwatch:*",
          "s3:*",
          "rds:*",
          "sqs:*",
          "sns:*",
          "logs:*",
          "ssm:*",
        ],
        Resource = "*"
      }
    ]
  })
}