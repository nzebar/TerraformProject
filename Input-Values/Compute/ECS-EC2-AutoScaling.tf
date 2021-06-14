module "AUTO_SCALING_GROUPS_1_VPC1" {
  source = "../../Modules/Compute-Modules/Default-Modules/ECS-EC2-AutoScaling-Modules"

##################
## ECS: Cluster ##
##################

create_new_ecs_cluster = false
new_ecs_cluster_settings = {
  settings = {
      name = "Cluster Yuh"

      existing_capacity_providers = []
      new_capacity_provider_key = []

      default_capacity_provider_strategies = {
        cap_1 = {
          capacity_provider = "1"
          weight = 0
          base = 0
        }
        cap_2 = {
          capacity_provider = "2"
          weight = 0
          base = 0
        }
      }

      enable_container_insights = false

      tags = {
        "key" = "value"
      }
  }
} 

#############################
## ECS: Capacity Providers ##
#############################

create_capacity_providers = false
capacity_providers = {
  cap_1 = {
    name = "cap_yuh"
    auto_scaling_group_arn = ""
    managed_termination_protection = "ENABLED"
    maximum_scaling_step_size = 1000
    minimum_scaling_step_size = 1
    status = "ENABLED"
    target_capacity = 10
  }
}

#################################
## Loadbalancer: Target Groups ##
#################################


## Load Balancer Target Groups ##

create_lb_target_groups = false

vpc_id = ""

lb_target_groups = {
  target_group_1 = {
    name = "target-group-yuh"
    protocol = "HTTP"
    port = 80
    target_type = "instance"
    app_lb_algorithm_type = "round_robin"
    health_check = {
      enabled = true
      path = ""
      port = 80
      protocol = "HTTP"
      healthy_threshold = 5
      interval = 5
      matcher = "200-299"
      timeout = 6
      unhealthy_threshold = 3
    }
    stickiness = {
      enabled = true
      type = "lb_cookie"
      cookie_duration = 30 
    }

    tags = {
      "key" = "value"
    }
  }
}
  
#########################
## Auto Scaling Group  ##
#########################

create_auto_scaling_groups = false

auto_scaling_groups = {

  #########################
  ## AutoScaling Group 1 ##
  #########################
  asg_1 = {
    ## General ##
      name = "sfghf"
      use_name_prefix = false
      service_linked_role_arn = ""

    ## Placement ##
      vpc_zone_identifier = []
      existing_target_group_arns = []
      new_target_group_keys = []
      placement_group = ""

    ## Launch ##

      # Launch Configuration
      use_launch_configuration = false
      launch_configuration_name = "asdasd" # Leave "" to use launch template

      # Launch Template
      use_launch_template = false
      launch_template_id = ""
      version = ""
        
      create_launch_template_overrides = false
      launch_template_overrides = {
        override_1 = {
          instance_type = ""
          weighted_capacity = ""
          launch_template_id = ""
        }
      }
        
      create_instance_distributions = false 
      instance_distributions = {
        settings = {
          on_demand_allocation_strategy = ""
          on_demand_base_capacity = 0
          on_demand_percentage_above_base_capacity = 0
          spot_allocation_strategy = ""
          spot_instance_pools = 0
          spot_max_price = ""
        }
      }
      
    ## Scaling ##
      max_size = 0
      min_size = 0
      desired_capacity = 0
      capacity_rebalance = false
      protect_from_scale_in = false
      max_instance_lifetime = 0
      default_cooldown = 0
    
    ## Health Check ##
      health_check_grace_period = 0
      health_check_type = ""
      min_elb_capacity = 0
      wait_for_capacity_timeout = ""

    ## LifeCycle Hooks ##
      create_initial_lifecycle_hooks = false
      initial_lifecycle_hooks = {
        hook_1 = {
          lifecycle_hook_name = "false" # Name must be unique
          notification_target_arn = ""
          role_arn = ""
          lifecycle_transition = ""
          heartbeat_timeout = 0
          default_result = ""
          notification_metadata = ""
        }
      }

      create_lifecycle_hooks = false
      lifecycle_hooks = {
        hook_1 = {
          lifecycle_hook_name = "" # Name must be unique
          autoscaling_group_name = ""
          notification_target_arn = ""
          role_arn = ""
          lifecycle_transition = ""
          heartbeat_timeout = 0
          default_result = ""
          notification_metadata = ""
        }
      }

    ## Warm Pool ##
      create_warm_pool = false
      warm_pool = {
        settings = {
          pool_state = "Running"
          min_size = 0
          max_group_prepared_capacity = 0
        }
      }

    ## Instance Refresh ##
      create_instance_refresh = false
      instance_refresh = {
        settings = {
          strategy = "Rolling"
          preferences = {
            instance_warmup = 0
            min_healthy_percentage = 0
          }
          triggers = []
        }
      }
    ## Metrics ##
      enabled_metrics = []
      metrics_granularity = ""

    ## Terminate ##
      suspended_processes = [] 
      termination_policies = []
      force_delete = false

    ## Tags ##
      tags = [{
      "key" = "yuhkey"
      "value" = "yuhval"
      "propagate_at_launch" = "true"
      },
    ]
    }

  
















  }

  

























}