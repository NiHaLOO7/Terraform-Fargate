variable "region" {
  default="eu-west-1"
  description = "region of aws"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
  description = "vpc CIDR block"
}

variable "public_subnet_1_cidr" {
    description = "public subnet 1 CIDR"
}

variable "public_subnet_2_cidr" {
    description = "public subnet 2 CIDR"
}

variable "public_subnet_3_cidr" {
    description = "public subnet 3 CIDR"
}

variable "private_subnet_1_cidr" {
    description = "private subnet 1 CIDR"
}

variable "private_subnet_2_cidr" {
    description = "private subnet 2 CIDR"
}

variable "private_subnet_3_cidr" {
    description = "private subnet 3 CIDR"
}