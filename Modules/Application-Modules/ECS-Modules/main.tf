locals {
  task_defs_vol = flatten( [ for task_defs, definitions in var.task_definitions: definitions.volume ] )

  task_defs_vol_docker_config = flatten( [ for task_defs, definitions in var.task_definitions: definitions.volume.docker_volume_configuration ] )

  volume_docker_driver_opts = flatten( [ for task_defs, definitions in var.task_definitions: definitions.volume.docker_volume_configuration.driver_opts ] )

  volume_docker_labels = flatten( [ for task_defs, definitions in var.task_definitions: definitions.volume.docker_volume_configuration.labels ] )

  task_defs_vol_efs_config = flatten( [ for task_defs, definitions in var.task_definitions: definitions.volume.efs_volume_configuration ] )

  volume_efs_auth_config = flatten( [ for task_defs, definitions in var.task_definitions: definitions.volume.efs_volume_configuration.authorization_config ] )
}


#################
## ECS Cluster ##
#################

resource "aws_ecs_cluster" "foo" {
count = var.create_ecs_cluster == true ? 1 : 0
  name = var.ecs_cluster_name
  capacity_providers = var.capacity_providers

  dynamic "default_capacity_provider_strategy" {
  for_each = var.default_capacity_provider_strategy
  content {
      capacity_provider = default_capacity_provider_strategy.value.capacity_provider
      weight = default_capacity_provider_strategy.value.weight
      base = default_capacity_provider_strategy.value.base
    }
  }

  setting {
    name  = lookup(var.ecs_cluster_setting, "name", "")
    value = lookup(var.ecs_cluster_setting, "value", "")
  }

  tags = var.ecs_cluster_tags
}

#################
## ECS Service ##
#################

resource "aws_ecs_service" "ecs_service" {
for_each = var.create_ecs_services == true ? var.ecs_services : {}

  name            = each.value.name
  cluster         = each.value.cluster
  launch_type = each.value.launch_type
  scheduling_strategy = each.value.scheduling_strategy
  task_definition = each.value.task_definition
  enable_execute_command = each.value.enable_execute_command
  deployment_minimum_healthy_percent = each.value.deployment_minimum_healthy_percent
  deployment_maximum_percent = each.value.deployment_maximum_percent
  desired_count   = each.value.desired_count
  iam_role        = each.value.iam_role
 # depends_on      = [each.value.depends_on]
  

  deployment_controller {
   type = element( [ for k, v in lookup(var.ecs_services[each.key], "deployment_controller", null): v if k == "type" ], 0 )
  }

  dynamic "placement_constraints" {
      for_each = lookup(var.ecs_services[each.key], "create_placement_constraints", null) == true ? lookup(var.ecs_services[each.key], "placement_constraints", null) : {}
      content {
          type = placement_constraints.value.type
          expression = placement_constraints.value.expression
      }
  }

  deployment_circuit_breaker {
    enable = element( [ for k, v in lookup(var.ecs_services[each.key], "deployment_circuit_breaker", null): v if k == "enable" ], 0)
    rollback = element( [ for k, v in lookup(var.ecs_services[each.key], "deployment_circuit_breaker", null): v if k == "rollback" ], 0)
  }

  ordered_placement_strategy {
    type = element( [ for k, v in lookup(var.ecs_services[each.key], "ordered_placement_strategy", null): v if k == "type" ], 0 )
    field = element( [ for k, v in lookup(var.ecs_services[each.key], "ordered_placement_strategy", null): v if k == "field" ], 0 )
  }

  health_check_grace_period_seconds = each.value.health_check_grace_period_seconds
  load_balancer {
    target_group_arn = element( [ for k, v in lookup(var.ecs_services[each.key], "load_balancer", null): v if k == "target_group_arn" ] , 0)
    container_name   = element( [ for k, v in lookup(var.ecs_services[each.key], "load_balancer", null): v if k == "container_name" ] , 0)
    container_port   = element( [ for k, v in lookup(var.ecs_services[each.key], "load_balancer", null): v if k == "container_port" ] , 0)
  }

  network_configuration {
      subnets = element( [ for k, v in lookup(var.ecs_services[each.key], "network_configuration", null): v if k == "subnets" ], 0)
      security_groups = element( [ for k, v in lookup(var.ecs_services[each.key], "network_configuration", null): v if k == "security_groups" ], 0)
      assign_public_ip = element( [ for k, v in lookup(var.ecs_services[each.key], "network_configuration", null): v if k == "assign_public_ip" ] , 0)
  }

  dynamic "service_registries" {
    for_each = lookup(var.ecs_services[each.key], "create_service_registries", {} ) == true ? lookup(var.ecs_services[each.key], "service_registries", {} ) : {}
    content {
      registry_arn = service_registries.value.registry_arn
      port = service_registries.value.port
      container_port = service_registries.value.container_port
      container_name = service_registries.value.container_name
    }
  }

  force_new_deployment = each.value.force_new_deployment

  enable_ecs_managed_tags = each.value.enable_ecs_managed_tags
  propagate_tags = each.value.propagate_tags
  tags = each.value.tags
}

###########################
## ECS Capacity Provider ##
###########################

resource "aws_ecs_capacity_provider" "capacity_providers" {
  for_each = var.create_capacity_providers == true ? var.ecs_capacity_providers : {}

  name = each.value.name
  auto_scaling_group_provider {
    auto_scaling_group_arn         = element( [ for k, v in each.value.auto_scaling_group_provider: v if k == "auto_scaling_group_arn" ], 0)
    managed_termination_protection = element( [ for k, v in each.value.auto_scaling_group_provider: v if k == "managed_termination_protection" ], 0)

    managed_scaling {
      instance_warmup_period = element( [ for k, v in each.value.managed_scaling: v if k == "instance_warmup_period" ], 0)
      maximum_scaling_step_size = element( [ for k, v in each.value.managed_scaling: v if k == "maximum_scaling_step_size" ], 0)
      minimum_scaling_step_size = element( [ for k, v in each.value.managed_scaling: v if k == "minimum_scaling_step_size" ], 0)
      status                    = element( [ for k, v in each.value.managed_scaling: v if k == "status" ], 0)
      target_capacity           = element( [ for k, v in each.value.managed_scaling: v if k == "target_capacity" ], 0)
    }
  }
}

##########################
## ECS Task Definitions ##
##########################

resource "aws_ecs_task_definition" "service" {
for_each = var.create_task_definitions == true ? var.task_definitions : {}

  family = lookup(var.task_definitions[each.key], "family", null )
  task_role_arn = lookup(var.task_definitions[each.key], "task_role_arn", null )
  execution_role_arn = lookup(var.task_definitions[each.key], "execution_role_arn", null )
  container_definitions = file(each.value.container_definitions)

  cpu = lookup(var.task_definitions[each.key], "cpu", null )
  memory =  lookup(var.task_definitions[each.key], "memory", null )
  network_mode = lookup(var.task_definitions[each.key], "network_mode", null )
  pid_mode = lookup(var.task_definitions[each.key], "pid_mode", null )
  requires_compatibilities = lookup(var.task_definitions[each.key], "requires_compatibilities", null )

  proxy_configuration {
    container_name = element( [ for k, v in lookup(var.task_definitions[each.key], "proxy_configuration", null): v if k == "container_name" ] , 0)
    properties = element( [ for k, v in lookup(var.task_definitions[each.key], "proxy_configuration", null): v if k == "properties" ] , 0)
    type = element( [ for k, v in lookup(var.task_definitions[each.key], "proxy_configuration", null): v if k == "type" ] , 0)
  }

  dynamic "inference_accelerator" {
    for_each = lookup(var.task_definitions[each.key], "inference_accelerator", null) == true ? [1] : []
    content{
    device_name = element( [ for k, v in lookup(var.task_definitions[each.key], "inference_accelerator", null): v if k == "device_name" ] , 0)
    device_type = element( [ for k, v in lookup(var.task_definitions[each.key], "inference_accelerator", null): v if k == "device_type" ] , 0)
  }
}

  ipc_mode = each.value.ipc_mode

  dynamic "volume" {
  for_each = { for o in local.task_defs_vol: "${o.name}.${o.host_path}" => o }
  content{
    name     = volume.value.name
    host_path = volume.value.host_path
    dynamic "docker_volume_configuration" {
    for_each = { for o in local.task_defs_vol_docker_config: "${o.autoprovision}.${o.driver}${o.scope}" => o  } 
    content {
        autoprovision = docker_volume_configuration.value.autoprovision
        driver_opts = element(local.volume_docker_driver_opts, 0)
        driver = docker_volume_configuration.value.driver
        labels = element(local.volume_docker_labels, 0)
        scope = docker_volume_configuration.value.scope
      }
    }
    dynamic "efs_volume_configuration" {
    for_each = { for o in local.task_defs_vol_efs_config: "${o.file_system_id}.${o.root_directory}.${o.transit_encryption}.${o.transit_encryption_port}" => o }
    content {
        file_system_id = efs_volume_configuration.value.file_system_id
        root_directory = efs_volume_configuration.value.root_directory
        transit_encryption = efs_volume_configuration.value.transit_encryption
        transit_encryption_port = efs_volume_configuration.value.transit_encryption_port
        dynamic "authorization_config" {
        for_each = { for o in local.volume_efs_auth_config: "${o.access_point_id}.${o.iam}" => o}
          content {
          access_point_id = authorization_config.value.access_point_id
          iam = authorization_config.value.iam
          }
        }
      }
    }
  }
}

  dynamic "placement_constraints" {
  for_each = lookup(var.task_definitions[each.key], "create_placement_constraints", {} ) == true ? lookup(var.task_definitions[each.key], "placement_constraints", {} ) : {}
  content {
    type       = placement_constraints.value.type
    expression = placement_constraints.value.expression
  }
}

  tags = lookup(var.task_definitions[each.key], "tags", {} )
}