module "ECS_VPC1" {
    source = "../../Modules/CICD-Modules/ECS-Modules"

##################
## ECS Services ##
##################
create_ecs_services = true

## General Settings ##
  ecs_service_name = "YUH_Service"
  use_new_task_definition = true
  task_definition_arn = ""
  ecs_cluster = module.AUTO_SCALING_GROUPS.ecs_cluster.arn
  ecs_service_iam_role = ""

## Launch Settings ##
  launch_type = "EC2"
  platform_version = "" # Only valid when launch_type == "FARGATE"
  deployment_controller_type = "ECS"
  scheduling_strategy = "REPLICA"
  deployment_maximum_percent = 100
  deployment_minimum_healthy_percent = 100
  desired_count = 2
  health_check_grace_period_seconds = 300
  wait_for_steady_state = false

  configure_service_registry = false
  service_registry = {
    config = {
      registry_arn = ""
      port = 0
      container_port = 0
      container_name = "" 
    }
  }

  enable_deployment_circuit_breaker_logic = true
  enable_ecs_rollback = true

  configure_capacity_provider_strategies = true
  capacity_provider_strategies = {
    strategy_1 = {
        capacity_provider = module.AUTO_SCALING_GROUPS.capacity_provider_001.name
        base = 1
        weight = 1
    }
    strategy_2 = {
        capacity_provider = module.AUTO_SCALING_GROUPS.capacity_provider_002.name
        base = 0
        weight = 1
    }
  }

  configure_ordered_placement_strategy = false
  ordered_placement_strategy = {
    config = {
        type = ""
        field = ""
    }
  }

  configure_load_balancers = true
  load_balancers = {
      lb_1 = {
          elb_name = ""
          target_group_arn = module.AUTO_SCALING_GROUPS.target_group_1.arn
          container_name = "WordPress"
          container_port = 80
      }
      lb_2 = {
          elb_name = ""
          target_group_arn = module.AUTO_SCALING_GROUPS.target_group_2.arn
          container_name = "WordPress"
          container_port = 80
      }
  }

  configure_service_task_placement_constraints = false
  service_task_placement_constraints = {
    constraint_1 = {
        type = ""
        expression = ""
    }
  }

## Network Settings ##
  configure_network_configuration = false # Only valid for task definitions network_mode == "awsvpc"
  network_configuration = {
    config = {
        subnets = []
        security_groups = []
        assign_public_ip = false
    }
}

## Debug Settings ##
  enable_execute_command = false

## Overrwrite Settings ##
  force_new_deployment = false

## Tag Settings ##
  enable_ecs_managed_tags = false
  propagate_tags = ""
  ecs_service_tags = {
      "key" = "value"
  }



########################## 
## ECS Task Definitiona ##
##########################
create_task_definition = true

## General Settings ##
  family = "Task_Definition_001"
  task_role_arn = ""
  execution_role_arn = ""

## System Settings ##
  ecs_cpu = 0
  ecs_memory = 0
  ipc_mode = "task"
  pid_mode = "task"
  requires_compatibilities = ["EC2"]
  container_definitions = "Input-Values\\CICD\\Source\\Container-Definitions\\task_def.json" # Local file path to file containing container definitions

## GPU Settings ##
  configure_inference_accelerator = false
  inference_accelerator = {
    config = {
      device_name = ""
      device_type = ""
    }
  }

## Storage Settings ##
  volume_name = "TaskDef001RootMount"
  volume_host_path = "/etc/ecs"

  configure_docker_volume_configuration = true
  docker_volume_configuration = {
    config = {
      autoprovision = false
      scope = "task"
      driver_opts = {}
      driver = ""
      labels = {}
    }
  }

  configure_efs_volume_configuration = false
  efs_volume_configuration = {
    config = {
      file_system_id = ""
      root_directory = ""
      transit_encryption = "ENABLED"
      transit_encryption_port = 21
      authorization_config = {
          access_point_id = ""
          iam = true
      }
    }
  }

  configure_fsx_windows_file_server_volume_configuration = false
  fsx_windows_file_server_volume_configuration = {
    config = {
      file_system_id = ""
      root_directory = ""
      authorization_config = {
          credentials_parameter = ""
          domain = ""
      }
    }
  }

  configure_ephemeral_storage = false # AWS Fargate Only
  ephemeral_storage = {
    size_in_gib = 0
  }

  ## Network Settings ##
  network_mode = "bridge"

  configure_proxy_configuration = false
  proxy_configuration = {
    config = {
      type = "APPMESH"
      container_name = ""
      properties = {}
    }
  }

  ## Placement Settings ##
  configure_task_placement_constraints = false
  task_placement_constraints = {
      constraint_1 = {
          type = ""
          expression = ""
      }
  }

  ## Tag Settings ##
  task_definition_tags = {
      "key" = "value"
  }






}