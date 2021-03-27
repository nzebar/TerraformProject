variable "group_name" {
    type = string
    description = "Specify the group name please"
}

variable "group_put_path" {
    type = string
    description = "Location of where the group will be on the AWS file structure"
}

variable "add_users" {
    type = list
    description = "Specify the users to add to the group"
}

variable "role_name" {
    type = string
    description = "Name to be used for the Role"
}

variable "role_put_path" {
    type = string
    description = "Location of where the role will be on the AWS file structure"
}

variable "trust_policy_string" {
    type = string
    desription = "String of principles add to the trust policy."
}

variable "policy_name" {
    type = string
    description = Name to be used for the Policy.
}

variable "policy_put_path" {
    type = string
    desscription = "Location of where to put the policy on the AWS file structure."
}

variable "policy_description" {
    type = string
    description = "Description of policy."
}

variable "policy_get_location" {
    type = string
    description = "Location of policy on local filesystem to be used"
}

variable "permission_boundary_name" {
    type = string
    description = "Name to be used for the permission boundary"
}

variable "permission_boundary_put_path" {
    type = string
    description = "Location to put the permission boundary on the AWS file structure."
}

variable "permission_boundary_description" {
    type = string
    description = "Description of permission boundary."
}

variable "permission_boundary_get_location" {
    type = string
    description = "Location of permission boundary on local file system to be used."
}