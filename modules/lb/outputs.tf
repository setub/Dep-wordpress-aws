output "lb_dns_name" {
  value = aws_alb.application_load_balancer.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.target_group.arn
}

output "lb_security_group" {
  value = aws_security_group.load_balancer_security_group.id
}