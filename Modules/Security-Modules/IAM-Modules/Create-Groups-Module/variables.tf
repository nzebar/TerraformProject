variable "group_name" {
  description = "Name of IAM Group & IAM Group Policy"
  type        = list(string)
  default = []
}

variable "group_policy_name" {
  description = "Name of IAM Group"
  type        = list(string)
  default = []
}

variable "assumable_roles_aws" {
  description = "List of IAM roles ARNs from the AWS console which can be assumed by the group"
  type        = list(string)
  default     = []
}

variable "attach_roles_local" {
  description = "List of IAM roles ARNs created in the Create-Multiple-Roles.tf file  which can be assumed"
  type        = list(string)
  default     = []
}

variable "use_roles_local" {
  description = "List of IAM roles ARNs created in the Create-Multiple-Roles.tf file  which can be assumed"
  type        = list(string)
  default     = []
}

variable "assumable_roles_create_local_module" {
  description = "List of IAM roles ARNs from the create users module which can be assumed by the group"
  type        = list(string)
  default     = []
}

variable "group_users" {
  description = "List of IAM users to have in an IAM group which can assume the role"
  type        = list(string)
  default     = []
}

variable "group_membership_name" {
  description = "Membership name to assign to users added to the group."
  type        = list(string)
  default     = []
}



