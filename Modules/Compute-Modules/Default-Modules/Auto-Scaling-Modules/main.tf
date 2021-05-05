locals {
  
  instances_distributions = flatten([for launch_template, instance_distributions in var.mixed_instances_policy: instance_distributions if instance_distributions == "instance_distributions"])
}

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

  mixed_instances_policy {
     launch_template {
      dynamic "launch_template_specification" {
        for_each = [ for launch_template_specification, launch_settings in lookup(var.mixed_instances_policy, "launch_template", {}): launch_settings if launch_template_specification == "launch_template_specification" ]
        content{
          launch_template_id = lookup(launch_template_specification.value, "launch_template_id", "")
          version = lookup(launch_template_specification.value, "version", "")
        }
      }
    dynamic "override" {
      for_each = lookup(var.mixed_instances_policy["launch_template"], "create_override", {}) == true ? lookup(var.mixed_instances_policy["launch_template"], "override_settings", {}) : {}
        content{
          instance_type = lookup(override.value, "instance_type", "")
          weighted_capacity = lookup(override.value, "weighted_capacity", "")
          dynamic "launch_template_specification" {
            for_each = [ for template_override, template in override.value: template if template_override == "launch_template_specification"]
            content{
            launch_template_id = lookup(launch_template_specification.value, "launch_template_override", null)
            version = lookup(launch_template_specification.value, "version", null)
          }
        }
      }
    }
  }
    dynamic "instances_distribution" {
      for_each = lookup(var.mixed_instances_policy, "create_instances_distribution", {}) ? lookup(var.mixed_instances_policy, "instances_distribution", {}) : {}
      content {
      on_demand_allocation_strategy            = each.value.on_demand_allocation_strategy
      on_demand_base_capacity                  = each.value.on_demand_base_capacity
      on_demand_percentage_above_base_capacity = each.value.on_demand_percentage_above_base_capacity
      spot_allocation_strategy                 = each.value.spot_allocation_strategy
      spot_instance_pools                      = each.value.spot_instance_pools
      spot_max_price                           = each.value.spot_max_price
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
    for_each = var.create_instance_refresh == true ? var.instance_refresh : []
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

  tags = var.tags
  

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      load_balancers,
      target_group_arns
    ]
  }
}

###############################
## Application Load Balancer ##
###############################

resource "aws_lb" "app_lb" {
count = var.create_app_lb == true ? 1 : 0

  name               = var.app_lb_name
  internal           = var.app_lb_internal
  load_balancer_type = "application"
  security_groups    = var.app_lb_security_groups
  subnets            = var. app_lb_subnets
  drop_invalid_header_fields = var.app_lb_drop_invalid_header_fields
  idle_timeout = var.app_lb_idle_timeout
  enable_deletion_protection = var.app_lb_deletion_protection
  enable_http2 = var.app_lb_enable_http2
  customer_owned_ipv4_pool = var.app_lb_customer_owned_ipv4_pool 
  ip_address_type = var.app_lb_ip_address_type

###############################################
## Application Load Balancer: Subnet Mapping ##
###############################################

  dynamic "subnet_mapping" {
    for_each = var.create_app_lb_subnet_mapping == true ? var.app_lb_subnet_mapping : {}
    content{
      subnet_id = lookup(subnet_mapping.value, "subnet_id", null)
      allocation_id = lookup(subnet_mapping.value, "allocation_id", null)
      private_ipv4_address = lookup(subnet_mapping.value, "private_ipv4_address", null)
      ipv6_address = lookup(subnet_mapping.value, "ipv6_address", null)
    }
  }

###############################################
## Application Load Balancer: S3 Access Logs ##
###############################################

  dynamic "access_logs" {
    for_each = var.create_s3_access_logs == true ? var.s3_access_logs : {}
    content{
      bucket  = each.value.bucket
      prefix  = each.value.prefix
      enabled = each.value.enable
    }
  }

  tags = merge({
    Environment = var.app_lb_environment
  },
    var.app_lb_tags,
  )
}

##############################################
## Application Load Balancer: Target Groups ##
##############################################

resource "aws_lb_target_group" "target_group" {
  for_each = var.create_app_lb_target_groups == true ? var.app_lb_target_groups : {}
      vpc_id = lookup(var.app_lb_target_groups[each.key], "vpc_id", null)
      name = lookup(var.app_lb_target_groups[each.key], "name", null)
      name_prefix = lookup(var.app_lb_target_groups[each.key], "name_prefix", null)
      target_type = lookup(var.app_lb_target_groups[each.key], "target_type", null)
      port = lookup(var.app_lb_target_groups[each.key], "port", null)
      protocol = lookup(var.app_lb_target_groups[each.key], "protocol", null)
      protocol_version = lookup(var.app_lb_target_groups[each.key], "protocol_version", null)
      proxy_protocol_v2 = lookup(var.app_lb_target_groups[each.key], "proxy_protocol_v2", null)
      preserve_client_ip = lookup(var.app_lb_target_groups[each.key], "preserve_client_ip", null)
      deregistration_delay = lookup(var.app_lb_target_groups[each.key], "deregistration_delay", null)
      slow_start = lookup(var.app_lb_target_groups[each.key], "slow_start", null)
      lambda_multi_value_headers_enabled = lookup(var.app_lb_target_groups[each.key], "lambda_multi_value_headers_enabled", null)
      dynamic "health_check" {
        for_each = [ for health_check in var.app_lb_target_groups[each.key]: health_check if health_check == "health_check"]
        content{
          enabled = lookup(health_check.value, "enabled", null)
          healthy_threshold = lookup(health_check.value, "healthy_threshold", null)
          interval = lookup(health_check.value, "interval", null)
          matcher = lookup(health_check.value, "matcher", null)
          path = lookup(health_check.value, "path", null)
          port = lookup(health_check.value, "port", null)
          protocol = lookup(health_check.value, "protocol", null)
          timeout = lookup(health_check.value, "timeout", null)
          unhealthy_threshold = lookup(health_check.value, "unhealthy_threshhold", null)
        }
      }
      dynamic "stickiness" {
        for_each = [ for stickiness in var.app_lb_target_groups[each.key]: stickiness if stickiness == "stickiness"]
        content{
        enabled = lookup(stickiness.value, "enabled", null)
        type = lookup(stickiness.value, "type", null)
        cookie_duration = lookup(stickiness.value, "cookie_duration", null)
        }
      }
      tags = lookup(var.app_lb_target_groups[each.key], "tags", null)
}

#####################################################
## Application Load Balancer: Listener Certificate ##
#####################################################

resource "aws_lb_listener_certificate" "https_cert" {
  for_each = var.https_certificates
  listener_arn    = lookup(var.https_certificates[each.key], "listener_arn", null)
  certificate_arn = lookup(var.https_certificates[each.key], "certificate_arn", null)
}

##########################################
## Application Load Balancer: Listeners ##
##########################################

resource "aws_lb_listener" "app_lb_listener" {
for_each = var.app_lb_listeners

  load_balancer_arn = aws_lb.app_lb[0].arn
  port              = each.value["port"]
  protocol          = each.value["protocol"]
  ssl_policy        = each.value["ssl_policy"]
  certificate_arn   = each.value["certificate_arn"]

  dynamic "default_action" {
    for_each = var.app_lb_listeners
    content{
      type             = lookup(default_action.value["default_action"], "type", null)
      dynamic "forward" {
          for_each = [ for type, value in lookup(var.app_lb_listeners[each.key], "default_action", null): value if type == "forward" ] == "forward"  ? [for forward in lookup(var.app_lb_listeners[each.key], "default_action", null): forward if forward == "forward"] : []
          content {
            target_group {
              arn = lookup(forward.value["target_group"], "arn", null)
              weight = lookup(forward.value["target_group"], "weight", null)
            }
          }
        }
      dynamic "redirect" {
        for_each = [ for type, value in lookup(var.app_lb_listeners[each.key], "default_action", null): value if type == "redirect" ] == "redirect" ? [for forward in lookup(var.app_lb_listeners[each.key], "default_action", null): forward if forward == "redirect"] : []
        content {
            port        = lookup(redirect.value, "port", null)
            protocol    = lookup(redirect.value, "protocol", null)
            status_code = lookup(redirect.value, "status_code", null)
        }
      }
      dynamic "fixed_response" {
        for_each = [ for type, value in lookup(var.app_lb_listeners[each.key], "default_action", null): value if type == "redirect" ] == "fixed_response" ? [for forward in lookup(var.app_lb_listeners[each.key], "default_action", null): forward if forward == "fixed_response"] : []
        content {
            content_type = lookup(fixed_response.value, "content_type", null)
            message_body = lookup(fixed_response.value, "message_body", null)
            status_code  = lookup(fixed_response.value, "status_code", null)
        }
      }
      dynamic "authenticate_cognito" {
        for_each = [ for type, value in lookup(var.app_lb_listeners[each.key], "default_action", null): value if type == "authenticate_cognito" ] == "authenticate_cognito" ? [for forward in lookup(var.app_lb_listeners[each.key], "default_action", null): forward if forward == "authenticate_cognito"] : []
        content{
            user_pool_arn       = lookup(authenticate_cognito.value, "user_pool_arn", null)
            user_pool_client_id = lookup(authenticate_cognito.value, "user_pool_client_id", null)
            user_pool_domain    = lookup(authenticate_cognito.value, "user_pool_domain", null)
            session_timeout = lookup(authenticate_cognito.value, "session_timeout", null)
            session_cookie_name = lookup(authenticate_cognito.value, "session_cookie_name", null)
            scope = lookup(authenticate_cognito.value, "scope", null)
            on_unauthenticated_request = lookup(authenticate_cognito.value, "on_unauthenticated_request", null)
            authentication_request_extra_params = lookup(authenticate_cognito.value, "authentication_request_extra_params", null)
        }
      }
      dynamic "authenticate_oidc" {
        for_each = [ for type, value in lookup(var.app_lb_listeners[each.key], "default_action", null): value if type == "authenticate_oidc" ] == "authenticate_oidc" ? [for forward in lookup(var.app_lb_listeners[each.key], "default_action", null): forward if forward == "authenticate_oidc"] : []
        content{
            authorization_endpoint = lookup(authenticate_oidc.value, "authorization_endpoint", null)
            client_id              = lookup(authenticate_oidc.value, "client_id", null)
            client_secret          = lookup(authenticate_oidc.value, "client_secret", null)
            issuer                 = lookup(authenticate_oidc.value, "issuer", null)
            token_endpoint         = lookup(authenticate_oidc.value, "token_endpoint", null)
            user_info_endpoint     = lookup(authenticate_oidc.value, "user_info_endpoint", null)
        }
      }
    }
  }
}

###############################################
## Application Load Balancer: Listener Rules ##
###############################################

resource "aws_lb_listener_rule" "this_rule" {
for_each = var.https_listener_rules

  listener_arn = aws_lb_listener.app_lb_listener[lookup(var.https_listener_rules[each.key], "listener_map_key_name", each.key)].arn
  priority     = lookup(var.https_listener_rules[each.key], "priority", null)

  action {     
        type = lookup(var.https_listener_rules[each.key], "type", null)
        dynamic "forward" {
          for_each = lookup(var.https_listener_rules[each.key], "type", null) == "forward" ? [for forward in lookup(var.https_listener_rules[each.key], "actions", null): forward if forward == "forward" ] : []
          content{
           target_group { 
                arn = lookup(forward.value["target_group"], "arn", null)
                weight = lookup(forward.value["target_group"], "weight", null)
            }
        }
      }
        dynamic "redirect" {
          for_each = lookup(var.https_listener_rules[each.key], "type", null) == "redirect" ? [for forward in lookup(var.https_listener_rules[each.key], "actions", null): forward if forward == "redirect" ] : []
          content{
            port = lookup(redirect.value, "port", null)
            protocol = lookup(redirect.value, "protocol", null)
            status_code = lookup(redirect.value, "status_code", null)
          }
        }
        dynamic "fixed_response" {
          for_each = lookup(var.https_listener_rules[each.key], "type", null) == "fixed-response" ? [for forward in lookup(var.https_listener_rules[each.key], "actions", null): forward if forward == "fixed_response" ] : []
          content {
            content_type = lookup(fixed_response.value, "content_type", null)
            message_body = lookup(fixed_response.value, "message_body", null)
            status_code = lookup(fixed_response.value, "status_code", null)
          }
        }
        dynamic "authenticate_cognito" {
          for_each = lookup(var.https_listener_rules[each.key], "authenticate", false) == true ? [for authentication in lookup(var.https_listener_rules[each.key], "authentication", null): authentication if authentication == "cognito" ] : []
          content{
            user_pool_arn       = lookup(authenticate_cognito.value["cognito"], "user_pool_arn", null)
            user_pool_client_id = lookup(authenticate_cognito.value["cognito"], "user_pool_client_id", null)
            user_pool_domain    = lookup(authenticate_cognito.value["cognito"], "user_pool_domain", null)
            session_timeout = lookup(authenticate_cognito.value["cognito"], "session_timeout", null)
            session_cookie_name = lookup(authenticate_cognito.value["cognito"], "session_cookie_name", null)
            scope = lookup(authenticate_cognito.value["cognito"], "scope", null)
            on_unauthenticated_request = lookup(authenticate_cognito.value["cognito"], "on_authenticated_request", null)
            authentication_request_extra_params = lookup(authenticate_cognito.value["cognito"], "authentication_request_extra_params", null)
          }
        }
        dynamic "authenticate_oidc" {
          for_each = lookup(var.https_listener_rules[each.key], "authenticate", false) == true ? [for authentication in lookup(var.https_listener_rules[each.key], "authentication", null): authentication if authentication == "oidc" ] : []
          content {
            authorization_endpoint = lookup(authenticate_oidc.value["oidc"], "authorization_endpoint", null)
            client_id              = lookup(authenticate_oidc.value["oidc"], "client_id", null)
            client_secret          = lookup(authenticate_oidc.value["oidc"], "client_secret", null)
            issuer                 = lookup(authenticate_oidc.value["oidc"], "issuer", null)
            token_endpoint         = lookup(authenticate_oidc.value["oidc"], "token_endpoint", null)
            user_info_endpoint     = lookup(authenticate_oidc.value["oidc"], "user_info_endpoint", null)
          }
        }
    }
  

      # Host Header condition
      condition {
          dynamic "host_header" {
            for_each = [ for conditions, host_header in lookup(var.https_listener_rules[each.key], "conditions", null): host_header if conditions == "host_header" ]
            content { 
            values = lookup(host_header.value, "values", null)
            }
          }
          dynamic "http_header" {
            for_each = [ for conditions, http_header in lookup(var.https_listener_rules[each.key], "conditions", null): http_header if conditions == "http_header" ]
            content { 
              http_header_name = lookup(http_header.value, "http_header_name", null)
              values           = lookup(http_header.value, "values", null)
            }
          }
          dynamic "http_request_method"{
            for_each = [ for conditions, http_request_method in lookup(var.https_listener_rules[each.key], "conditions", null): http_request_method if conditions == "http_request_method" ]
            content {
              values = lookup(http_request_method.value, "values", null)
            }
          }
          dynamic "path_pattern" {
            for_each = [ for conditions, path_pattern in lookup(var.https_listener_rules[each.key], "conditions", null): path_pattern if conditions == "path_pattern" ]
            content {
              values = lookup(path_pattern.value, "values", null)
            }
          }
          dynamic "query_string" {
            for_each = [ for conditions, query_string in lookup(var.https_listener_rules[each.key], "conditions", null): query_string if conditions == "query_string" ]
            content {
              key   = lookup(query_string.value, "key", null)
              value = lookup(query_string.value, "value", null)
            }
          }
          dynamic "source_ip" {
            for_each = [ for conditions, source_ip in lookup(var.https_listener_rules[each.key], "conditions", null): source_ip if conditions == "source_ip" ] 
            content {
              values = lookup(source_ip.value, "values", null)
            }
          }

        }




}
     