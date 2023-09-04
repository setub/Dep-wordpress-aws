resource "aws_cloudwatch_log_group" "wordpress_log" {
  name = "ecs/wordpress"
  retention_in_days = 14
}

output "wordpress-log-name" {
 value = aws_cloudwatch_log_group.wordpress_log.name
}