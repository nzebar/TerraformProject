
# Role Variables

variable "create_role" {
  description = "Whether to create a role"
  type        = bool
  default     = false
}

variable "create_instance_profile" {
  description = "Whether to create an instance profile"
  type        = bool
  default     = false
}

variable "role_name" {
  description = "IAM role name"
  type        = string
  default     = ""
}

variable "role_description" {
  description = "IAM Role description"
  type        = string
  default     = ""
}

variable "role_path" {
  description = "Path of IAM role"
  type        = string
  default     = "/"
}

variable "force_detach_policies" {
  description = "Whether policies should be detached from this role when destroying"
  type        = bool
  default     = false
}

variable "role_requires_mfa" {
  description = "Whether role requires MFA"
  type        = string
  default     = "true"
}

variable "mfa_age" {
  description = "Max age of valid MFA (in seconds) for roles which require MFA"
  type        = number
  default     = 86400
}

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  type        = number
  default     = 3600
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
  type        = string
  default     = ""
}

variable "permission_boundary_policy_description" {
  description = "Permission boundary applied to the role"
  type        = string
  default     = ""
}

variable "var.permission_boundary_path" {
  description = "Permission boundary applied to the role"
  type        = string
  default     = ""
}

variable "role_permission_boundary_local_path" {
  description = "Permission boundary applied to the role"
  type        = string
  default     = ""
}

# Local policies to attach to the role

variable "attach_admin_policy" {
  description = "Whether to attach an admin policy to a role"
  type        = bool
  default     = false
}

    variable "admin_policy_name" {
      description = "Admin policy name to use for admin role"
      type        = string
      default     = ""
    }

    variable "admin_policy_description" {
      description = "Admin policy description to use for admin role"
      type        = string
      default     = ""
    }

    variable "admin_role_policy_local_path" {
      description = "Local path of admin policy to use for admin role"
      type        = set(string)
      default     = []
    }

variable "attach_poweruser_policy" {
  description = "Whether to attach a poweruser policy to a role"
  type        = bool
  default     = false
}


    variable "poweruser_policy_name" {
      description = "Poweruser policy name to use for poweruser role"
      type        = string
      default     = ""
    }

    variable "poweruser_policy_description" {
      description = "Poweruser policy description to use for poweruser role"
      type        = string
      default     = ""
    }

     variable "poweruser_role_policy_local_path" {
      description = "Local path of poweruser policy to use for role"
      type        = set(string)
      default     = []
    }

variable "attach_readonly_policy" {
  description = "Whether to attach a readonly policy to a role"
  type        = bool
  default     = false
}

    variable "readonly_role_policy_local_path" {
      description = "Policy ARN to use for readonly role"
      type        = set(string)
      default     = []
    }

    variable "readonly_policy_name" {
      description = "Readnly policy name to use for readonly role"
      type        = string
      default     = ""
    }

    variable "readonly_policy_description" {
      description = "Readonly policy description to use for readonly role"
      type        = string
      default     = ""
    }



variable "custom_policy_name" {
  description = "Custom policy name to use for the role"
  type        = string
  default     = ""
}

variable "custom_policy_description" {
  description = "Custom policy name to use for the role"
  type        = string
  default     = ""
}

variable "custom_role_policy_local_path" {
  description = "Local file paths for custom IAM policies to attach to IAM role"
  type        = set(string)
  default     = []
}

variable "number_of_custom_policy_local_path" {
  description = "Number of custom local IAM policies to attach to IAM role"
  type        = number
  default     = null
}




