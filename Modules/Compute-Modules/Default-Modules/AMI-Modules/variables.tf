###################
## AMI Variables ## 
###################

variable "AMI" {
  description = "Mapping of maps for AMIs to be created"
  type = map(any)
  default = null
}