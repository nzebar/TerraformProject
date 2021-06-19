###############################################
## Application Load Balancer Security Groups ##
###############################################

output "app_lb_security_group" {
  value = aws_security_group.new_security_groups["lb_001_app_security_group"]
}