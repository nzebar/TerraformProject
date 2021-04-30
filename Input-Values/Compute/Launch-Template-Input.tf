module "LAUNCH_TEMPLATE_1_VPC1" {
  source = "../../Modules/Compute-Modules/Default-Modules/Launch-Template-Modules"

#######################
## Launch Template 1 ##
#######################

  create_lt = false 
  lt_use_name_prefix = false
  lt_name = "TestTemplate"
  description = "This is a test template"

  ebs_optimized = false
  image_id      = ""
  instance_type = ""
  key_name      = ""
  user_data_base64     = ""

  security_groups = [""]

  default_version                      = 1
# update_default_version               = false
  disable_api_termination              = false
  instance_initiated_shutdown_behavior = "stop"
  kernel_id                            = ""
  ram_disk_id                          = ""

  create_block_device_mappings = false
    block_device_mappings = [{
        device_name  = ""
        no_device    = false
        virtual_name = ""
          ebs = {
              delete_on_termination = false
              encrypted             = false
              kms_key_id            = ""
              iops                  = ""
              throughput            = 0
              snapshot_id           = ""
              volume_size           = 0
              volume_type           = ""
          }
    }]

  create_capacity_reservation_specification = false
    capacity_reservation_specification = {
      capacity_reservation_preference = ""
        capacity_reservation_target = {
          capacity_reservation_id = ""
        }
    }

  create_cpu_options = false
    cpu_options = {
      core_count = ""
      threads_per_core = ""
    }

  create_credit_specification = false
    credit_specification = {
      cpu_credits = ""
    }

  create_elastic_gpu_specifications = false
    elastic_gpu_specifications = {
      type = ""
    }

  create_elastic_inference_accelerator = false
    elastic_inference_accelerator = {
      type = ""
    }

  create_enclave_options = false
    enclave_options = {
      enabled = false
    }

  create_hibernation_options = false
    hibernation_options = {
      configured = false
    }

  create_iam_instance_profile = false
  iam_instance_profile = {
      name = ""
      arn = ""
  }

  create_instance_market_options = false
    instance_market_options = [{
      market_type = ""
      create_spot_options = false
      spot_options = [{
        block_duration_minutes = 0
        instance_interruption_behavior = ""
        max_price = ""
        spot_instance_type = ""
        valid_until = ""
      }]
    }]

  create_license_specifications = false
    license_specifications = {
      license_configuration_arn = ""
    }

  create_metadata_options = false
    metadata_options = {
      http_endpoint = ""
      http_tokens = ""
       http_put_response_hop_limit = 1
    }

  create_monitoring = false
    monitoring = [{
      enabled = false
    }]

  create_network_interfaces = false
    network_interfaces = [{
      associate_carrier_ip_address = false
      associate_public_ip_address  = false
      delete_on_termination        = false
      description                  = ""
      device_index                 = 0
      ipv4_addresses               = []
      ipv4_address_count           = 0
      ipv6_addresses               = []
      ipv6_address_count           = 0
      network_interface_id         = ""
      private_ip_address           = ""
      security_groups              = []
      subnet_id                    = ""
    }]

  create_placement = false
    placement = {
      affinity          = ""
      availability_zone = ""
      group_name        = ""
      host_id           = ""
      spread_domain     = ""
      tenancy           = ""
      partition_number  = 0
    }

  create_tag_specifications = false
  tag_specifications = [{
    resource_type = ""
    tags = {}
  }]

  tags_as_map = {
    "key" = "value"
  }
}