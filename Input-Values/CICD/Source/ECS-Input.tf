module "ECS_VPC1" {
    source = "../../../Modules/CICD-Modules/ECS-Modules"

#################
## ECS Cluster ##
#################

    create_ecs_cluster = true

    ecs_cluster_name = "clusteryuh"
    capacity_providers = [""]
    default_capacity_provider_strategy = {
        capacity_provider_1 = {
            capacity_provider = ""
            weight = 50
            base = 0
        }
        capacity_provider_2 = {
            capacity_provider = ""
            weight = 50
            base = 0
        }
    }
    ecs_cluster_setting = {
        name = "containerInsights"
        value = ""
    }
    ecs_cluster_tags = {
        "key" = "value"
    }


##################
## ECS Services ##
##################

    create_ecs_services = true

    ecs_services = {
        ecs_service_1 = {
            name            = ""
            cluster         = "theyuhservice"
            launch_type = "EC2"
            scheduling_strategy = "DAEMON"
            task_definition = ""
            enable_execute_command = false 
            deployment_minimum_healthy_percent = 100
            deployment_maximum_percent = 100
            desired_count   = 4
            iam_role        = ""
            depends_on      = [""]
            deployment_controller = {
                type = "ECS"
            }
            create_placement_constraints = false
            placement_constraints = {
                constraint_1 = {
                    type = ""
                    expression = ""
                }
            }
            ordered_placement_strategy = {
                type = "binpack"
                field = "cpu"
            }
            deployment_circuit_breaker = {
                enable = false
                rollback = true
            }
            health_check_grace_period_seconds = 30
            load_balancer = {
                target_group_arn = ""
                container_name = "The_container_of_yuh"
                container_port = 443
            }
            network_configuration = {
                subnets = [""]
                security_groups = [""]
                assign_public_ip = false
            }
            create_service_registry = false
            service_registries = {
                registry_1 = {
                    registry_arn = "yuh_registry"
                    port = 443
                    container_port = 443
                    container_name = "container_yuh"
               }
            }
            force_new_deployment = false
            enable_ecs_managed_tags = false
            propagate_tags = "TASK_DEFINITION"
            tags = {
                "keyyuh" = "valueyuh"
            }
        }
    }

############################
## ECS Capacity Providers ##
############################

create_capacity_providers = true

ecs_capacity_providers = {
    capacity_provider_1 = {
        name = ""
        auto_scaling_group_provider = {
            auto_scaling_group_arn = ""
            managed_termination_protection = "ENABLED"
        }
        managed_scaling = {
            instance_warmup_period = 30
            maximum_scaling_step_size = 1000
            minimum_scaling_step_size = 1
            status = "ENABLED"
            target_capacity = 4
        }
    }
}


########################## 
## ECS Task Definitiona ##
##########################

create_task_definitions = true

task_definitions = {
    task_def_1 = {
        family = "famyuh"
        task_role_arn = ""
        execution_role_arn = ""
        container_definitions = "Input-Values\\CICD\\Source\\Container-Definitions\\task_def.json" # Local file path to file containing container definitions

        cpu = 2
        memory = 6
        pid_mode = "host"
        requires_compatabilities = ["EC2"]
        ipc_mode = "host"

        configure_task_def_volume = false
        volume = {
            name = "volyuh"
            host_path = "/the/yuh/path"
            #create_docker_volume_configuration = true
            docker_volume_configuration = {
                autoprovision = false
                driver_opts = {}
                driver = ""
                labels = {}
                scope = "shared"
            }
            #create_efs_volume_configuration = true
            efs_volume_configuration = {
                file_system_id = ""
                root_directory = ""
                transit_encryption = "ENABLED"
                transit_encryption_port = 21
                authorization_config = {
                    access_point_id = ""
                    iam = "ENABLED"
                }
            }
        }

        network_mode = "bridge"
        create_inference_accelerator = false
        inference_accelerator = {
            device_name = ""
            device_type = ""
        }

        create_placement_constraints = false
        placement_constraints = {
            constraint_1 = {
                expression = ""
                type = ""
            }
        }

        proxy_configuration = {
            container_name = ""
            properties = {}
            type = "APPMESH"
        }

        tags = {
            "keyyuh" = "valueyuh"
        }

    }
}








}