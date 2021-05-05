module "AUTO_SCALING_GROUPS_1_VPC1" {
  source = "../../Modules/Compute-Modules/Default-Modules/Auto-Scaling-Modules"
  
#########################
## Auto Scaling Group  ##
#########################

  create_asg = true

  asg_use_name_prefix = true
  asg_name = "Testasg"

  availability_zone  = [""]
  vpc_zone_identifier = [""]

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
  target_group_arns         = [] # Can Specify the target groups created below something different
  placement_group           = ""
  health_check_type         = ""
  health_check_grace_period = 300

  force_delete          = true
  suspended_processes   = []
  max_instance_lifetime = 604800

  enabled_metrics         = []
  metrics_granularity     = ""
  service_linked_role_arn = "" 

  use_launch_configuration = false
  launch_configuration = ""

  mixed_instances_policy = {
  # REQUIRED: Launch template to use for ASG
    launch_template = {
      launch_template_specification = {
        launch_template_id = "id-7567344534555"
        version = "$latest"
        }
  # Able to create multiple overrides
  create_override = true
    override_settings = {
    # Map key names must be unique
      override_1 = {
        instance_type = "test1"
        weighted_capacity = "1"
        launch_template_specification = {
          launch_template_id = "hello"
          version = "$latest"
        } 
      }
      override_2 = {
        instance_type = "test2"
        weighted_capacity = "1"
        launch_template_specification = {
          launch_template_id = "world"
          version = "$latest"
        } 
      }
      override_3 = {
        instance_type = "test3"
        weighted_capacity = "1"
        launch_template_specification = {
          launch_template_id = ""
          version = ""
        } 
      }
        
    }
  }
  create_instances_distribution = false
    instances_distribution = {
      on_demand_allocation_strategy            = "heloo"
      on_demand_base_capacity                  = "world"
      on_demand_percentage_above_base_capacity = "i"
      spot_allocation_strategy                 = "am"
      spot_instance_pools                      = "kinda"
      spot_max_price                           = "here"
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

    delete_timeout = "10m"

    tags = [{
      "key" = "value"
    }]

###############################
## Application Load Balancer ##
###############################

  create_app_lb = true
  app_lb_environment = "development"

  app_lb_name = "test"
  app_lb_internal = false
  app_lb_security_groups = []
  app_lb_subnets = []
  app_lb_drop_invalid_header_fields = false
  app_lb_idle_timeout = 60
  app_lb_deletion_protection = false
  app_lb_enable_http2 = false
  app_lb_customer_owned_ipv4_pool = ""
  app_lb_ip_address_type = "ipv4"

##############################################
## Application Load Balancer: Target Groups ##
##############################################

create_app_lb_target_groups = true
app_lb_target_groups = {
    target_group_1 = {
      vpc_id = "id-634345ffsss"
      name = "TG1"
      target_type = "instance"
      port = 443
      protocol = "HTTPS"
      deregistration_delay = 10
      slow_start = 30
      health_check = {
        enabled = true
        healthy_threshold = 3
        unhealthy_threshhold = 3
        interval = 30
        matcher = "200-299"
        path = "/"
        port = 80
        protocol = "HTTP"
        timeout = 10
      }
      tags = {
        "key" = "value"
      }
    }
}

#####################################################
## Application Load Balancer: Listener Certificate ##
#####################################################

https_certificates = {
  # cert_1 = {
  #   listener_arn = "arn:aws:elastic-loadbalancing:us-east-1:*:listener/L1"
  #   certificate_arn = "arn:aws:acm:us-east-1:*:certificiate/C1"
  # }
}

###############################################
## Application Load Balancer: Subnet Mapping ##
###############################################

  create_app_lb_subnet_mapping = false
    app_lb_subnet_mapping = {
      mapping_1 = {
        subnet_id = "id-sgvbsdfgbfgb"
        allocation_id = "id-123456677"
        private_ipv4_address = "192.168.1.5"
       # ipv6_address = ""
      }
      
    }

##########################################
## Application Load Balancer: Listeners ##
##########################################

  app_lb_listeners = {
    Listener_1 = {
      port = 443
      protocol = "HTTPS"
      ssl_policy = "ELBSecurityPolicy-2016-08"
      certificate_arn = ""
      default_action = {
        type = "forward"
        forward = {
          target_group = { arn = "", weight = 50 }
          target_group ={arn = "", weight = 50}
        }
        redirect = {
          port        = "443"
          protocol    = "HTTPS"
          status_code = "HTTP_301"
        }
         fixed_response = {
          content_type = "text/plain" 
          message_body = "fixed response content"
          status_code  = "200"
         }
        authenticate_cognito = {
          user_pool_arn       = "sdfgdcv"
          user_pool_client_id = "id-83424"
          user_pool_domain    = "canttakeitanymore.com"
          
        }
        authneticate_oidc = {
          authorization_endpoint = "https://example.com/authorization_endpoint"
          client_id              = "client_id"
          client_secret          = "client_secret"
          issuer                 = "https://example.com"
          token_endpoint         = "https://example.com/token_endpoint"
          user_info_endpoint     = "https://example.com/user_info_endpoint"
        }
        
        # authenticate_oidc = {}
      }
    }


  }

###############################################
## Application Load Balancer: Listener Rules ##
###############################################

https_listener_rules = {
    
    rule_1 = {
      listener_map_key_name = "Listener_1"
      priority = 100
      type = "forward"

      actions = {
        forward = {
            target_group = { arn = "asdfvxcv", weight = 50}
            target_group = { arn = "sssssss", weight = 50}
            }
    #   redirect = {}
    #   fixed_response = {}
      }

    # authenticate = true
    #   authentication = {
    #     cognito = {}
    #     oidc = {}
    #   }

      conditions = {
        host_header = {values = ["afgd.com"]}
    #   http_header = {}
    #   http_request_method = {}
    #   path_pattern = { }
    #   query_string = {}
    #   source_ip = {}
      }
    } 

}
    

    

  

  create_s3_access_logs = false
    s3_access_logs = {
      bucket = ""
      prefix = ""
      enable = false
    }

  app_lb_tags = {
    "key" = "value"
  }








}