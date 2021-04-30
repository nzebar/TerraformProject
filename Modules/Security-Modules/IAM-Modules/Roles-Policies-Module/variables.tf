
# Role Variables

variable "create_role" {
  description = "Whether to create a role"
  type        = list(string)
  default     = ["false"]
}

variable "create_instance_profile" {
  description = "Whether to create an instance profile"
  type        = list(string)
  default     = ["false"]
}

variable "role_name" {
  description = "IAM role name"
  type        = list(string)
  default     = []
}

variable "role_description" {
  description = "IAM Role description"
  type        = list(string)
  default     = []
}

variable "role_path" {
  description = "Path of IAM role"
  type        = list(string)
  default     = ["/"]
}

variable "force_detach_policies" {
  description = "Whether policies should be detached from this role when destroying"
  type        = list(string)
  default     = ["false"]
}

variable "role_requires_mfa" {
  description = "Whether role requires MFA"
  type        = list(string)
  default     = ["true"]
}

variable "mfa_age" {
  description = "Max age of valid MFA (in seconds) for roles which require MFA"
  type        = list(string)
  default     = ["86400"]
}

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  type        = list(string)
  default     = ["3600"]
}

variable "tags" {
  description = "A map of tags to add to IAM role resources"
  type        = map(string)
  default     = {}
}

# Trusted Role Variables

variable "trusted_role_actions" {
  description = "Actions of STS"
  type        = list(string)
  default     = ["sts:AssumeRole"]
}

variable "role_sts_externalid" {
  description = "STS ExternalId condition values to use with a role (when MFA is not required)"
  type        = list(string)
  default     = []
}

variable "trusted_role_arns" {
  description = "ARNs of AWS entities who can assume these roles"
  type        = list(string)
  default     = []
}

variable "trusted_role_services" {
  description = "AWS Services that can assume these roles"
  type        = list(string)
  default     = []
}

# Permission Boundary Variables

variable "permission_boundary_policy_name" {
  description = "Permission boundary applied to the role"
  type        = list(string)
  default     = null
}

variable "permission_boundary_policy_description" {
  description = "Permission boundary applied to the role"
  type        = list(string)
  default     = null
}

variable "permission_boundary_path" {
  description = "Permission boundary applied to the role"
  type        = list(string)
  default     = null
}

variable "role_permission_boundary_local_path" {
  description = "Permission boundary applied to the role"
  type        = list(string)
  default     = null
}

# Local policies to attach to the role

variable "attach_policy" {
  description = "Whether to attach an admin policy to a role"
  type        = list(string)
  default     = ["false"]
}

    variable "policy_name" {
      description = "Admin policy name to use for admin role"
      type        = list(string)
      default     = []
    }

    variable "policy_description" {
      description = "Admin policy description to use for admin role"
      type        = list(string)
      default     = []
    }

    variable "policy_path" {
      type = list(string)
      default = []
    }

    variable "policy_local_path" {
      description = "Local path of admin policy to use for admin role"
      type        = list(string)
      default     = []
    }






