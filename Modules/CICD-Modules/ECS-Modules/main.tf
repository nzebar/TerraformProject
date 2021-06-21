#################
## ECS Service ##
#################

resource "aws_ecs_service" "ecs_service" {
count = var.create_ecs_services == true ? 1 : 0

## General Settings ##
  name            = var.ecs_service_name
  task_definition = var.use_new_task_definition == true ? aws_ecs_task_definition.service[0].arn : var.task_definition_arn
  cluster         = var.ecs_cluster
  iam_role        = var.ecs_service_iam_role

## Launch Settings ##
  launch_type = var.launch_type
  platform_version = var.launch_type == "FARGATE" ? var.platform_version : null
  deployment_controller {
    type = var.deployment_controller_type
  }
  scheduling_strategy = var.scheduling_strategy
  deployment_maximum_percent = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  desired_count = var.desired_count
  health_check_grace_period_seconds = var.health_check_grace_period_seconds
  wait_for_steady_state = var.wait_for_steady_state

  dynamic "service_registries" {
    for_each = var.configure_service_registry == true ? var.service_registry : {}
    content {
      registry_arn = service_registries.value.registry_arn
      port = service_registries.value.port
      container_port = service_registries.value.container_port
      container_name = service_registries.value.container_name
    }
  }

  deployment_circuit_breaker {
    enable = var.enable_deployment_circuit_breaker_logic
    rollback = var.enable_ecs_rollback
  }

  dynamic "capacity_provider_strategy" {
    for_each = var.configure_capacity_provider_strategies == true ? var.capacity_provider_strategies : {}
    content {
      capacity_provider = capacity_provider_strategy.value.capacity_provider
      base = capacity_provider_strategy.value.base
      weight = capacity_provider_strategy.value.weight
    } 
  }

  dynamic "ordered_placement_strategy" {
    for_each = var.configure_ordered_placement_strategy == true ? var.ordered_placement_strategy : {}
    content {
      type = ordered_placement_strategy.value.type
      field = ordered_placement_strategy.value.field
    }
  }

  dynamic "load_balancer" {
    for_each = var.configure_load_balancers == true ? var.load_balancers : {}
    content {
      elb_name = load_balancer.value.elb_name == "" ? null : load_balancer.vlaue.elb_name
      target_group_arn = load_balancer.value.target_group_arn
      container_name = load_balancer.value.container_name
      container_port = load_balancer.value.container_port
    }
  }

  dynamic "placement_constraints" {
    for_each = var.configure_service_task_placement_constraints == true ? var.service_task_placement_constraints : {}
    content {
      type = placement_constraints.value.type
      expression = placement_constraints.value.expression
    }
  }

## Network Settings ##

  dynamic "network_configuration" {
    for_each = var.configure_network_configuration == true ? var.network_configuration : {}
    content {
      subnets = network_configuration.value.subnets
      security_groups = network_configuration.value.security_groups
      assign_public_ip = network_configuration.value.assign_public_ip
    }
  }

## Debug Settings ##

  enable_execute_command = var.enable_execute_command

## Overrwrite Settings ##

  force_new_deployment = var.force_new_deployment

## Tag Settings ##
  enable_ecs_managed_tags = var.enable_ecs_managed_tags
  propagate_tags = var.propagate_tags
  tags = var.ecs_service_tags

}

##########################
## ECS Task Definitions ##
##########################

resource "aws_ecs_task_definition" "service" {
count = var.create_task_definition == true ? 1 : 0

## General Settings ##
  family = var.family
  task_role_arn = var.task_role_arn
  execution_role_arn = var.execution_role_arn

## System Settings ##
  cpu = var.ecs_cpu
  memory =  var.ecs_memory
  ipc_mode = var.ipc_mode == "" ? null : var.ipc_mode
  pid_mode = var.pid_mode == "" ? null : var.pid_mode
  requires_compatibilities = var.requires_compatibilities
  container_definitions = file(var.container_definitions)

## GPU Settings ##
  dynamic "inference_accelerator" {
    for_each = var.configure_inference_accelerator == true ? var.inference_accelerator : {}
    content {
      device_name = inference_accelerator.value.device_name
      device_type = inference_accelerator.value.defvice_type
    }
  }

## Storage Settings ##
volume {
  name = var.volume_name
  host_path = var.volume_host_path
    dynamic "docker_volume_configuration" {
      for_each = var.configure_docker_volume_configuration == true ? var.docker_volume_configuration : {}
      content {
        autoprovision = docker_volume_configuration.value.autoprovision
        scope = docker_volume_configuration.value.scope
        driver_opts = docker_volume_configuration.value.driver_opts
        driver = docker_volume_configuration.value.driver
        labels = docker_volume_configuration.value.labels
      }
    }
    dynamic "efs_volume_configuration" {
      for_each = var.configure_efs_volume_configuration == true ? var.efs_volume_configuration : {}
      content {
        file_system_id = efs_volume_configuration.value.file_system_id
        root_directory = efs_volume_configuration.value.root_directory
        transit_encryption = efs_volume_configuration.value.transit_encryption
        transit_encryption_port = efs_volume_configuration.value.transit_encryption_port
        authorization_config {
          access_point_id = efs_volume_configuration.value.authorization_config.access_point_id
          iam = efs_volume_configuration.value.authorization_config.iam
      }
    }
  }
    dynamic "fsx_windows_file_server_volume_configuration" {
      for_each = var.configure_fsx_windows_file_server_volume_configuration == true ? var.fsx_windows_file_server_volume_configuration : {}
      content {
        file_system_id = fsx_windows_file_server_volume_configuration.value.file_system_id
        root_directory = fsx_windows_file_server_volume_configuration.value.root_directory
        authorization_config {
          credentials_parameter = fsx_windows_file_server_volume_configuration.value.authorization_config.credentials_parameter
          domain = fsx_windows_file_server_volume_configuration.value.authorization_config.domain
      }
    }
  }
}

dynamic "ephemeral_storage" {
  for_each = var.configure_ephemeral_storage == true ? var.ephemeral_storage : {}
  content {
    size_in_gib = var.ephemeral_storage["size_in_gib"]
  }
}

## Network Settings ##
  network_mode = var.network_mode

  dynamic "proxy_configuration" {
    for_each = var.configure_proxy_configuration == true ? var.proxy_configuration : {}
    content {
      type = proxy_configuration.value.type
      container_name = proxy_configuration.value.container_name
      properties = proxy_configuration.value.properties
    }
  }

## Placement Constraints ##
  dynamic "placement_constraints" {
  for_each = var.configure_task_placement_constraints == true ? var.task_placement_constraints : {}
  content {
    type       = placement_constraints.value.type
    expression = placement_constraints.value.expression
  }
}

## Tag Settings ##
  tags = var.task_definition_tags

}