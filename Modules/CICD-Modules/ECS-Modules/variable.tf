###########################
## ECS Cluster Variables ##
###########################

variable "create_ecs_cluster" {
    description = "Whether or not create an ECS Cluster"
    type = bool
    default = false
}

variable "ecs_cluster_name" {
    description = "Name of the ECS cluster"
    type = string
    default = null
}

variable "capacity_providers" {
    description = "List of capacity providers for the ecs cluster"
    type = list(string)
    default = []
}

variable "default_capacity_provider_strategy" {
    description = "Mapping of objects for the capacity providers in the default strategy"
    type = map(object({
        capacity_provider = string
        weight = number
        base = number
    }))
    default = null
}

variable "ecs_cluster_setting" {
    description = "mapping of name and value for the ECS cluster setting"
    type = map(string)
    default = {}
}

variable "ecs_cluster_tags" {
    description = "String mapping of tags for the ECS CLuster"
    type = map(string)
    default = {}
}

############################
## ECS Services Variables ##
############################

variable "create_ecs_services" {
    description = "Whether or not to create the ecs services"
    type = bool 
    default = false
}

variable "ecs_services" {
    description = "Mapping of objects for the ECS service to be created"
    type = map(object({
        name            = string
        cluster         = string
        launch_type = string
        scheduling_strategy = string
        task_definition = string
        enable_execute_command = bool 
        deployment_minimum_healthy_percent = number
        deployment_maximum_percent = number
        desired_count   = number
        iam_role        = string
        depends_on      = list(string)
        deployment_controller = map(string)
        placement_constraints = map(map(string))
        ordered_placement_strategy = map(string)
        deployment_circuit_breaker = map(bool)
        health_check_grace_period_seconds = number
        load_balancer = object({
            target_group_arn = string
            container_name = string
            container_port = number
        })
        network_configuration = object({
            subnets = list(string)
            security_groups = list(string)
            assign_public_ip = bool
        })
        service_registries = map(object({
            registry_arn = string
            port = number
            container_port = number
            container_name = string
        }))
        force_new_deployment = bool
        enable_ecs_managed_tags = bool
        propagate_tags = string
        tags = map(string)
    }))
    default = {}
}

############################
## ECS Capacity Providers ##
############################

variable "create_capacity_providers" {
    description = "Whether or not to create Capacity Providers for the ECS Cluster"
    type = bool
    default = false
}

variable "ecs_capacity_providers" {
    description = "Mapping of objects for the capacity providers to be created for the ECS Cluster"
    type = map(object({
        name = string
        auto_scaling_group_provider = map(string)
        managed_scaling = object({
            instance_warmup_period = number
            maximum_scaling_step_size = number
            minimum_scaling_step_size = number
            status                    = string
            target_capacity           = number
        })
    }))
}

##########################
## ECS Task Definitions ##
##########################

variable "create_task_definitions" {
    description = "Whether or not to create ecs tasl definitions"
    type = bool
    default = false
}

variable "task_definitions" {
    description = "Mapping of objects for task definitions to be create for the ECS services"
    type = any
    default = null
}