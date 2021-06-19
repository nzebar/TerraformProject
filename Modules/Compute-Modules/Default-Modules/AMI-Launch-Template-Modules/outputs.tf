############################
## Launch Template Output ##
############################

output "LT_001" {
  value = aws_launch_template.this[0]
}

## EBS Output ##

# output "ebs_1" {
#   value = aws_ebs_snapshot.new_ebs_snapshot["ebs_1"]
# }