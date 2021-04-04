variable "Group_Name_Policy_Name" {
  description = "Name of IAM Group & IAM Group Policy"
  type        = string
}

variable "assumable_roles_aws" {
  description = "List of IAM roles ARNs from the AWS console which can be assumed by the group"
  type        = list(string)
  default     = []
}

variable "assumable_roles_create_users_module" {
  description = "List of IAM roles ARNs from the create users module which can be assumed by the group"
  type        = list(string)
  default     = []
}

variable "group_users" {
  description = "List of IAM users to have in an IAM group which can assume the role"
  type        = list(string)
  default     = []
}



