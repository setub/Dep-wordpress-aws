variable "ecs-cluster-name" {
  default = "wordpress-cluster"
}

variable "ecs-service-name" {
  default = "wordpress-service"
}

variable "ecs-load-balancer-name" {
  default = "wordpress-load-balancer"
}

variable "ecs-alb-target" {
  default = "wordpress-target-group"
}

variable "ecs-task-execution-role-arn" {
  description = "ecs Task Execution Role Arn"
}

variable "vpc-id" {}
variable "rds-security-group" {}
variable "rds-url" {}
variable "rds-username" {}
variable "rds-password" {}
variable "rds-dbname" {}
variable "wordpress-image" {}
variable "ecs-target-group-arn" {}
variable "lb-security-group" {}
variable "cloudwatch-log" {}
variable "aws-region" {}

variable "subnets" {
  type = list(string)
}