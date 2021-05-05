##################################
## Auto Scaling Group Variables ##
##################################

variable "create_asg" {
  description = "Determines whether to create autoscaling group or not"
  type        = bool
  default     = true
}

variable "asg_name" {
  description = "Name used across the resources created"
  type        = string
  default = ""
}

variable "asg_use_name_prefix" {
  description = "Determines whether to use `name` as is or create a unique name beginning with the `name` as the prefix"
  type        = bool
  default     = true
}

variable "use_launch_configuration" {
  description = "Name of an existing launch configuration to be used (created outside of this module)"
  type        = bool
  default     = false
}

variable "use_launch_template" {
  description = "Name of an existing launch configuration to be used (created outside of this module)"
  type        = bool
  default     = null
}

variable "launch_configuration" {
  description = "Name of an existing launch configuration to be used (created outside of this module)"
  type        = string
  default     = null
}

variable "launch_template" {
  description = "Name of an existing launch template to be used (created outside of this module)"
  type        = map(string)
  default     = null
}

variable "lt_version" {
  description = "Launch template version. Can be version number, `$Latest`, or `$Default`"
  type        = string
  default     = null
}

variable "availability_zone" {
  description = "A list of one or more availability zones for the group. Used for EC2-Classic and default subnets when not specified with `vpc_zone_identifier` argument. Conflicts with `vpc_zone_identifier`"
  type        = list(string)
  default     = null
}

variable "vpc_zone_identifier" {
  description = "A list of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside. Conflicts with `availability_zones`"
  type        = list(string)
  default     = null
}

variable "min_size" {
  description = "The minimum size of the autoscaling group"
  type        = number
  default     = null
}

variable "max_size" {
  description = "The maximum size of the autoscaling group"
  type        = number
  default     = null
}

variable "desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the autoscaling group"
  type        = number
  default     = null
}

variable "capacity_rebalance" {
  description = "Indicates whether capacity rebalance is enabled"
  type        = bool
  default     = null
}

variable "min_elb_capacity" {
  description = "Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes"
  type        = number
  default     = null
}

variable "wait_for_elb_capacity" {
  description = "Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over `min_elb_capacity` behavior."
  type        = number
  default     = null
}

variable "wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior."
  type        = string
  default     = null
}

variable "default_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  type        = number
  default     = null
}

variable "protect_from_scale_in" {
  description = "Allows setting instance protection. The autoscaling group will not select instances with this setting for termination during scale in events."
  type        = bool
  default     = false
}

variable "load_balancers" {
  description = "A list of elastic load balancer names to add to the autoscaling group names. Only valid for classic load balancers. For ALBs, use `target_group_arns` instead"
  type        = list(string)
  default     = null
}

variable "target_group_arns" {
  description = "A set of `aws_alb_target_group` ARNs, for use with Application or Network Load Balancing"
  type        = list(string)
  default     = null
}

variable "placement_group" {
  description = "The name of the placement group into which you'll launch your instances, if any"
  type        = string
  default     = null
}

variable "health_check_type" {
  description = "`EC2` or `ELB`. Controls how health checking is done"
  type        = string
  default     = null
}

variable "health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  type        = number
  default     = null
}

variable "force_delete" {
  description = "Allows deleting the Auto Scaling Group without waiting for all instances in the pool to terminate. You can force an Auto Scaling Group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling"
  type        = bool
  default     = null
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the Auto Scaling Group should be terminated. The allowed values are `OldestInstance`, `NewestInstance`, `OldestLaunchConfiguration`, `ClosestToNextInstanceHour`, `OldestLaunchTemplate`, `AllocationStrategy`, `Default`"
  type        = list(string)
  default     = null
}

variable "suspended_processes" {
  description = "A list of processes to suspend for the Auto Scaling Group. The allowed values are `Launch`, `Terminate`, `HealthCheck`, `ReplaceUnhealthy`, `AZRebalance`, `AlarmNotification`, `ScheduledActions`, `AddToLoadBalancer`. Note that if you suspend either the `Launch` or `Terminate` process types, it can prevent your Auto Scaling Group from functioning properly"
  type        = list(string)
  default     = null
}

variable "max_instance_lifetime" {
  description = "The maximum amount of time, in seconds, that an instance can be in service, values must be either equal to 0 or between 604800 and 31536000 seconds"
  type        = number
  default     = null
}

variable "enabled_metrics" {
  description = "A list of metrics to collect. The allowed values are `GroupDesiredCapacity`, `GroupInServiceCapacity`, `GroupPendingCapacity`, `GroupMinSize`, `GroupMaxSize`, `GroupInServiceInstances`, `GroupPendingInstances`, `GroupStandbyInstances`, `GroupStandbyCapacity`, `GroupTerminatingCapacity`, `GroupTerminatingInstances`, `GroupTotalCapacity`, `GroupTotalInstances`"
  type        = list(string)
  default     = null
}

variable "metrics_granularity" {
  description = "The granularity to associate with the metrics to collect. The only valid value is `1Minute`"
  type        = string
  default     = null
}

variable "service_linked_role_arn" {
  description = "The ARN of the service-linked role that the ASG will use to call other AWS services"
  type        = string
  default     = null
}

variable "create_initial_lifecycle_hooks" {
  description = "Whether to create initial lifestyle hook"
  type        = bool
  default     = false
}

variable "initial_lifecycle_hooks" {
  description = "One or more Lifecycle Hooks to attach to the Auto Scaling Group before instances are launched. The syntax is exactly the same as the separate `aws_autoscaling_lifecycle_hook` resource, without the `autoscaling_group_name` attribute. Please note that this will only work when creating a new Auto Scaling Group. For all other use-cases, please use `aws_autoscaling_lifecycle_hook` resource"
  type        = map(string)
  default     = {}
}

variable "create_instance_refresh" {
  description = "Whether tp create instance refresh"
  type        = bool
  default     = false
}

variable "instance_refresh" {
  description = "If this block is configured, start an Instance Refresh when this Auto Scaling Group is updated"
  type        = any
  default     = null
}

variable "mixed_instances_policy" {
  description = "Configuration block containing settings to define launch targets for Auto Scaling groups"
  type        = any
  default     = null
}



variable "delete_timeout" {
  description = "Delete timeout to wait for destroying autoscaling group"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tag blocks. Each element should have keys named key, value, and propagate_at_launch"
  type        = set(map(string))
  default     = [{}]
}

########################################
## Application Loadbalancer Variables ##
########################################

variable "create_app_lb" {
  description = "Whether a loadbalancer should be created"
  type = bool
  default = false
}

variable "app_lb_name" {
  description = "Name of App LB"
  type = string
  default = ""
}

variable "app_lb_internal" {
  description = "Whether the LB should be public or private"
  type = bool
  default = false
}

variable "app_lb_security_groups" {
  description = "List of security groups for the App LB"
  type = list(string)
  default = []
}

variable "app_lb_subnets" {
  description = "Subnets to place the LB hosts in"
  type = list(string)
  default = []
}

variable "app_lb_drop_invalid_header_fields" {
  description = "Whether the LB should drop invalid header fields or not"
  type = bool
  default = false
}

variable "app_lb_idle_timeout" {
  description = "Time in seconds before an idle connection is dropped"
  type = number
  default = 30
}

variable "app_lb_deletion_protection" {
  description = "Whether deletion protection of app LB is enabled or not"
  type = bool
  default = false
}

variable "app_lb_enable_http2" {
  description = "Whether to enable http2 for the LB or not"
  type = bool
  default = false
}

variable "app_lb_customer_owned_ipv4_pool" {
  description = "Customer owned ipv4 pools used in the LB"
  type = string
  default = ""
}

variable "app_lb_ip_address_type" {
  description = "The address type for the app LB"
  type = string
  default = ""
}

variable "create_app_lb_target_groups" {
  description = "whether to create target_groups for the app LB or not"
  type = bool
  default = false
}

variable "app_lb_target_groups" {
  description = "Target groups used for the app LB"
  type = map(any)
  default = {}
}

variable "https_certificates" {
  description = "Certs for the HTTPS target groups"
  type = map(any)
  default = {}
}

variable "create_app_lb_subnet_mapping" {
  description = "whether to create a subnet mapping for the app LB or not"
  type = bool
  default = false
}

variable "app_lb_subnet_mapping" {
  description = "subnet mapping used for the app LB"
  type = map(any)
  default = {}
}

variable "create_s3_access_logs" {
  description = "whether to create access s3 access logs for the app LB"
  type = bool
  default = false
}

variable "s3_access_logs" {
  description = "S3 Access Logs for the App LB"
  type = any
  default = {}
}

variable "app_lb_listeners" {
  description = "Listeners for the app LB"
  type = any
  default = {}
}

variable "https_listener_rules" {
  description = "Listener rules for the app LB"
  type = any
  default = {}
  
}

variable "app_lb_environment" {
  description = "The environment the app LB will be placed in"
  type = string
  default = ""
}

variable "app_lb_tags" {
  description = "Tags for the app LB"
  type = map(string)
  default = {}
}