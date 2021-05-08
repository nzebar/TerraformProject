variable "public_security_groups" {
  description = "Mapping of maps for specified security groups"
  type = map(any)
  default = null
}

variable "private_security_groups" {
  description = "Mapping of maps for specified security groups"
  type = map(any)
  default = null
}

variable "database_security_groups" {
  description = "Mapping of maps for specified security groups"
  type = map(any)
  default = null
}