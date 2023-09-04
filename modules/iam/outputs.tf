output "ecs_execution_role_arn" {
  value = "${aws_iam_role.ecsTaskExecutionRole.arn}"
}
