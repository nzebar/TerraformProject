module "AUTO_SCALING_GROUPS_1_VPC1" {
  source = "../../Modules/Compute-Modules/Default-Modules/Auto-Scaling-Group-Modules"
  
####################################################
## Auto Scaling Group: Create Auto Scaling Group  ##
####################################################

  create_asg = true
  asg_use_name_prefix = false
  asg_name = "Testasg"

  availability_zone  = []
  vpc_zone_identifier = []

  min_size                  = 0
  max_size                  = 0
  desired_capacity          = 0
  capacity_rebalance        = false
  min_elb_capacity          = 0
  wait_for_elb_capacity     = 0
  wait_for_capacity_timeout = "10m"
  default_cooldown          = 0
  protect_from_scale_in     = false
 
  load_balancers            = [] # Classic EC2 Only
  target_group_arns         = []
  placement_group           = ""
  health_check_type         = ""
  health_check_grace_period = 300

  force_delete          = false
  suspended_processes   = []
  max_instance_lifetime = 604800

  enabled_metrics         = []
  metrics_granularity     = ""
  service_linked_role_arn = "" 

  use_launch_configuration = false
  launch_configuration = ""

  use_launch_template = true
  launch_template = {
    id      = ""
    version = "$Latest"
  }

  create_mixed_instances_policy = false
    mixed_instances_policy = {
      launch_template = {
        launch_template_specification = {
          launch_template_id = ""
            override = {
              instance_type = ""
              weighted_capacity = 0
            }
          }
        }
    create_instances_distribution = false
        instances_distribution = {
          on_demand_allocation_strategy            = ""
          on_demand_base_capacity                  = ""
          on_demand_percentage_above_base_capacity = ""
          spot_allocation_strategy                 = ""
          spot_instance_pools                      = ""
          spot_max_price                           = ""
        }
      }

  create_initial_lifecycle_hooks = false
    initial_lifecycle_hooks = {
      name                    = "test"
      default_result          = ""
      heartbeat_timeout       = ""
      lifecycle_transition    = ""
      notification_metadata   = ""
      notification_target_arn = ""
      role_arn                = ""
    }

  create_instance_refresh = false
    instance_refresh = [{
      strategy = "Rolling"
      triggers = [""]
      create_preferences = false
        preferences = [{
          instance_warmup        = ""
          min_healthy_percentage = 0
        }]
    }]

    delete_timeout = ""

    tags = [{
      "key" = "value"
    }]

    






}