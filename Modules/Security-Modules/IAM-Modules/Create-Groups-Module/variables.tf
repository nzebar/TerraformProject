variable "name_group" {
  description = "Name of IAM Group & IAM Group Policy"
  type        = list(string)
  default = []
}

variable "path_group" {
  description = "Path to put group policy in the AWS console"
  type        = list(string)
  default = []
}

variable "group_memebers" {
  description = "Group members to add to the newly created group"
  type        = list(string)
  default = []
}

variable "group_policy_name" {
  description = "Name of IAM Group Policy"
  type        = list(string)
  default = []
}

variable "put_path_aws_group_policy" {
  description = "Path to put IAM group policy on AWS console"
  type        = list(string)
  default = []
}

variable "group_policy_local_path" {
  description = "Local path of json policy to use for IAM group policy"
  type        = list(string)
  default = []
}

variable "new_aws_console_users_with_password" {
  description = "AWS console users and passwords to be created"
  type        = list(string)
  default = []
}

variable "aws_console_user_password_reset" {
  description = "If the password should be reset when the new user logs in to their account"
  type        = list(string)
  default = []
}

variable "new_programmatic_users_with_pgp_key" {
  description = "Programmatic users with passwords to be created"
  type        = list(string)
  default = []
}