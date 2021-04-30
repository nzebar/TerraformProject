########################
## Auto Scaling Group ##
########################

resource "aws_autoscaling_group" "this" {
  count = var.create_asg ? 1 : 0

  name        = var.asg_use_name_prefix ? null : var.asg_name
  name_prefix = var.asg_use_name_prefix ? "${var.asg_name}-" : null

  launch_configuration = var.use_launch_configuration == true ? var.launch_configuration : null

  # availability_zones  = var.availability_zone
  vpc_zone_identifier = var.vpc_zone_identifier

  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  capacity_rebalance        = var.capacity_rebalance
  min_elb_capacity          = var.min_elb_capacity
  wait_for_elb_capacity     = var.wait_for_elb_capacity
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  default_cooldown          = var.default_cooldown
  protect_from_scale_in     = var.protect_from_scale_in

  load_balancers            = var.load_balancers
  target_group_arns         = var.target_group_arns
  placement_group           = var.placement_group
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period

  force_delete          = var.force_delete
  termination_policies  = var.termination_policies
  suspended_processes   = var.suspended_processes
  max_instance_lifetime = var.max_instance_lifetime

  enabled_metrics         = var.enabled_metrics
  metrics_granularity     = var.metrics_granularity
  service_linked_role_arn = var.service_linked_role_arn

  dynamic "launch_template" {
    for_each = var.use_launch_template == true ? var.launch_template : {}

    content{
    id = lookup(var.launch_template, "id", null)
    version = lookup(var.launch_template, "version", null)
    }
  } 

  dynamic "mixed_instances_policy" {
    for_each = var.create_mixed_instances_policy ? [var.mixed_instances_policy] : []
    content {
        dynamic "instances_distribution" {
            for_each = lookup(mixed_instances_policy.value, "create_instances_distribution", null) == true ? lookup(mixed_instances_policy.value, "instances_distribution", null) : []
            content {
            on_demand_allocation_strategy            = lookup(instances_distribution.value, "on_demand_allocation_strategy", null)
            on_demand_base_capacity                  = lookup(instances_distribution.value, "on_demand_base_capacity", null)
            on_demand_percentage_above_base_capacity = lookup(instances_distribution.value, "on_demand_percentage_above_base_capacity", null)
            spot_allocation_strategy                 = lookup(instances_distribution.value, "spot_allocation_strategy", null)
            spot_instance_pools                      = lookup(instances_distribution.value, "spot_instance_pools", null)
            spot_max_price                           = lookup(instances_distribution.value, "spot_max_price", null)
          }
        }
      }
    }

  dynamic "initial_lifecycle_hook" {
    for_each = var.create_initial_lifecycle_hooks == true ? var.initial_lifecycle_hooks : {}
    content {
      name                    = lookup(var.initial_lifecycle_hooks[each.key], "name", null)
      default_result          = lookup(var.initial_lifecycle_hooks[each.key], "default_result", null)
      heartbeat_timeout       = lookup(var.initial_lifecycle_hooks[each.key], "heartbeat_timeout", null)
      lifecycle_transition    = lookup(var.initial_lifecycle_hooks[each.key], "lifecycle_transition", null)
      notification_metadata   = lookup(var.initial_lifecycle_hooks[each.key], "notification_metadata", null)
      notification_target_arn = lookup(var.initial_lifecycle_hooks[each.key], "notification_target_arn", null)
      role_arn                = lookup(var.initial_lifecycle_hooks[each.key], "role_arn", null)
    }
  }

  dynamic "instance_refresh" {
    for_each = var.instance_refresh != null ? var.instance_refresh : []
    content {
      strategy = instance_refresh.value.strategy
      triggers = lookup(instance_refresh.value, "triggers", null)

      dynamic "preferences" {
        for_each = lookup(instance_refresh.value, "create_preferences", null) == true ? lookup(instance_refresh.value, "preferences", null) : []
        content {
          instance_warmup        = lookup(preferences.value, "instance_warmup", null)
          min_healthy_percentage = lookup(preferences.value, "min_healthy_percentage", null)
        }
      }
    }
  }

  timeouts {
    delete = var.delete_timeout
  }

  tags = concat(
    [
      {
        "key"                 = "Name"
        "value"               = var.asg_name
        "propagate_at_launch" = true
      },
    ],
    var.tags,
  )

  lifecycle {
    create_before_destroy = true
  }
}

########################################
## Auto Scaling Group: Lifecycle Hook ##
########################################