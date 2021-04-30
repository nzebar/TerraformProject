###############################
## Launch Template Variables ##
###############################

variable "create_lt" {
  description = "Whether to create the launch template or not."
  type = bool 
  default = false
}

variable "lt_use_name_prefix" {
  description = "Wheather to use a name prefix instead of a regular name"
  type = bool
  default = false
}

variable "lt_name" {
  description = "Name of launch template"
  type = string
  default = ""
}

variable "name" {
  description = "Name of launch template"
  type = string
  default = ""
}

variable "description" {
  description = "Description of launch template"
  type = string
  default = ""
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized."
  type = bool
  default = false
}

variable "image_id" {
  description = "The AMI id from which to launch the instance."
  type = string
  default = ""
}

variable "instance_type" {
  description = "The type of the instance."
  type = string
  default = ""
}

variable "key_name" {
  description = "The key name that should be used for the instance."
  type = string
  default = ""
}

variable "user_data_base64" {
  description = "The local path to the file containing user data"
  type = string
  default = ""
}

variable "security_groups" {
  description = "Securtiy groups to be used for the instance"
  type = list(string)
  default = []
}

variable "default_version" {
  description = "Default version of the launch template"
  type = string
  default = null
}

variable "update_default_version" {
  description = "Wheather to update the default version of the launch template. Conflicts with `default_version"
  type = string
  default = null
}

variable "disable_api_termination" {
  description = "If true, enables EC2 instance termination protection"
  type = bool
  default = null
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance. Can be `stop` or `terminate`. (Default: `stop`)"
  type = string
  default = null
}

variable "kernel_id" {
  description = "(LT) The kernel ID"
  type        = string
  default     = null
}

variable "ram_disk_id" {
  description = "(LT) The ID of the ram disk"
  type        = string
  default     = null
}

variable "create_block_device_mappings" {
  description = "Wheather to create the ebs block device mappings"
  type = bool
  default = false  
}

variable "block_device_mappings" {
  description = "(LT) Specify volumes to attach to the instance besides the volumes specified by the AMI"
  type        = list(any)
  default     = []
}

variable "create_capacity_reservation_specification" {
  description = "Wheather to create capacity reservation specification"
  type        = bool
  default     = false
}

variable "capacity_reservation_specification" {
  description = "(LT) Targeting for EC2 capacity reservations"
  type        = any
  default     = null
}

variable "create_cpu_options" {
  description = "Whether to create cpu options"
  type        = bool
  default     = false
}

variable "cpu_options" {
  description = "(LT) The CPU options for the instance"
  type        = map(string)
  default     = null
}

variable "create_credit_specification" {
  description = "Whether to create credit specification"
  type        = bool
  default     = false
}

variable "credit_specification" {
  description = "(LT) Customize the credit specification of the instance"
  type        = map(string)
  default     = null
}

variable "create_elastic_gpu_specifications" {
  description = "(LT) The elastic GPU to attach to the instance"
  type        = bool
  default     = false
}

variable "elastic_gpu_specifications" {
  description = "(LT) The elastic GPU to attach to the instance"
  type        = map(string)
  default     = null
}

variable "create_elastic_inference_accelerator" {
  description = "Whether to create an elastic inference accelerator"
  type        = bool
  default     = false
}

variable "elastic_inference_accelerator" {
  description = "(LT) Configuration block containing an Elastic Inference Accelerator to attach to the instance"
  type        = map(string)
  default     = null
}

variable "create_enclave_options" {
  description = "Whether to create enclave options"
  type        = bool
  default     = false
}

variable "enclave_options" {
  description = "(LT) Enable Nitro Enclaves on launched instances"
  type        = map(string)
  default     = null
}

variable "create_hibernation_options" {
  description = "Whether to create hibernation options"
  type        = bool
  default     = false
}

variable "hibernation_options" {
  description = "(LT) The hibernation options for the instance"
  type        = map(string)
  default     = null
}

variable "create_iam_instance_profile" {
  description = "Whether to create an IAM Instance Profile for the instance"
  type        = bool
  default     = false
}

variable "iam_instance_profile" {
  description = "(LT) The IAM Instance Profile ARN to launch the instance with"
  type        = map(string)
  default     = null
}

variable "create_instance_market_options" {
  description = "Whether to create instance market options"
  type        = bool
  default     = false
}

variable "instance_market_options" {
  description = "(LT) The market (purchasing) option for the instance"
  type        = any
  default     = null
}

variable "create_license_specifications" {
  description = "Whether to create create license specifications"
  type        = bool
  default     = false
}

variable "license_specifications" {
  description = "(LT) A list of license specifications to associate with"
  type        = map(string)
  default     = null
}

variable "create_metadata_options" {
  description = "Create metadata options"
  type        = bool
  default     = false
}

variable "metadata_options" {
  description = "Customize the metadata options for the instance"
  type        = map(string)
  default     = null
}

variable "create_monitoring" {
  description = "Whether to create monitoring"
  type = bool
  default = false
}

variable "monitoring" {
  description = "Specify if monitoring is enabled or disabled"
  type = list(any)
  default = null
}

variable "create_network_interfaces" {
  description = "whether to create network interfaces"
  type        = bool
  default     = false
}

variable "network_interfaces" {
  description = "(LT) Customize network interfaces to be attached at instance boot time"
  type        = list(any)
  default     = []
}

variable "create_placement" {
  description = "Whether to create a placement"
  type        = bool
  default     = false
}

variable "placement" {
  description = "(LT) The placement of the instance"
  type        = map(string)
  default     = null
}

variable "create_tag_specifications" {
  description = "whether to create tag specifications"
  type        = bool
  default     = false
}

variable "tag_specifications" {
  description = "(LT) The tags to apply to the resources during launch"
  type        = list(any)
  default     = []
}

variable "tags_as_map" {
  description = "Tags for the lainch template"
  type        = map(string)
  default     = {}
}

