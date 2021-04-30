#####################
## Launch template ##
#####################

locals {
  lt_name         = coalesce(var.lt_name, var.name)
  launch_template = var.create_lt ? aws_launch_template.this[0].name : ""
}

resource "aws_launch_template" "this" {
  count = var.create_lt ? 1 : 0

  name        = var.lt_use_name_prefix ? null : local.lt_name
  name_prefix = var.lt_use_name_prefix ? "${local.lt_name}-" : null
  description = var.description == var.description

  ebs_optimized = var.ebs_optimized
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = var.user_data_base64 == "" ? null : filebase64(var.user_data_base64)

  vpc_security_group_ids = var.security_groups 

  default_version                      = var.default_version
  update_default_version               = var.update_default_version
  disable_api_termination              = var.disable_api_termination
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  kernel_id                            = var.kernel_id
  ram_disk_id                          = var.ram_disk_id

  dynamic "block_device_mappings" {
    for_each = var.create_block_device_mappings == true ? var.block_device_mappings : []
    content {
      device_name  = block_device_mappings.value.device_name
      no_device    = lookup(block_device_mappings.value, "no_device", null)
      virtual_name = lookup(block_device_mappings.value, "virtual_name", null)

      dynamic "ebs" {
        for_each = flatten([lookup(block_device_mappings.value, "ebs", [])])
        content {
          delete_on_termination = lookup(ebs.value, "delete_on_termination", null)
          encrypted             = lookup(ebs.value, "encrypted", null)
          kms_key_id            = lookup(ebs.value, "kms_key_id", null)
          iops                  = lookup(ebs.value, "iops", null)
          throughput            = lookup(ebs.value, "throughput", null)
          snapshot_id           = lookup(ebs.value, "snapshot_id", null)
          volume_size           = lookup(ebs.value, "volume_size", null)
          volume_type           = lookup(ebs.value, "volume_type", null)
        }
      }
    }
  }

  dynamic "capacity_reservation_specification" {
    for_each = var.create_capacity_reservation_specification == true ? [var.capacity_reservation_specification] : []
    content {
      capacity_reservation_preference = lookup(capacity_reservation_specification.value, "capacity_reservation_preference", null)

      dynamic "capacity_reservation_target" {
        for_each = lookup(capacity_reservation_specification.value, "capacity_reservation_target", [])
        content {
          capacity_reservation_id = lookup(capacity_reservation_target.value, "capacity_reservation_id", null)
        }
      }
    }
  }

  dynamic "cpu_options" {
    for_each = var.create_cpu_options == true ? var.cpu_options : {}
    content {
      core_count       = cpu_options.value.core_count
      threads_per_core = cpu_options.value.threads_per_core
    }
  }

  dynamic "credit_specification" {
    for_each = var.create_credit_specification == true ? var.credit_specification : {}
    content {
      cpu_credits = credit_specification.value.cpu_credits
    }
  }

  dynamic "elastic_gpu_specifications" {
    for_each = var.create_elastic_gpu_specifications == true ? var.elastic_gpu_specifications : {}
    content {
      type = elastic_gpu_specifications.value.type
    }
  }

  dynamic "elastic_inference_accelerator" {
    for_each = var.create_elastic_inference_accelerator == null ? var.elastic_inference_accelerator : {}
    content {
      type = elastic_inference_accelerator.value.type
    }
  }

  dynamic "enclave_options" {
    for_each = var.create_enclave_options == true ? var.enclave_options : {}
    content {
      enabled = enclave_options.value.enabled
    }
  }

  dynamic "hibernation_options" {
    for_each = var.create_hibernation_options == true ? var.hibernation_options : {}
    content {
      configured = hibernation_options.value.configured
    }
  }

  dynamic "iam_instance_profile" {
    for_each = var.create_iam_instance_profile == true ? var.iam_instance_profile : {}
    content {
      name = var.iam_instance_profile_name
      arn  = var.iam_instance_profile_arn
    }
  }

  dynamic "instance_market_options" {
    for_each = var.create_instance_market_options == true ? var.instance_market_options : []
    content {
      market_type = instance_market_options.value.market_type

      dynamic "spot_options" {
        for_each = lookup(instance_market_options.value, "create_spot_options", false) == true ? [instance_market_options.value.spot_options] : []
        content {
          block_duration_minutes         = spot_options.value.block_duration_minutes
          instance_interruption_behavior = lookup(spot_options.value, "instance_interruption_behavior", null)
          max_price                      = lookup(spot_options.value, "max_price", null)
          spot_instance_type             = lookup(spot_options.value, "spot_instance_type", null)
          valid_until                    = lookup(spot_options.value, "valid_until", null)
        }
      }
    }
  }

  dynamic "license_specification" {
    for_each = var.create_license_specifications == true ? var.license_specifications : {}
    content {
      license_configuration_arn = license_specifications.value.license_configuration_arn
    }
  }

  dynamic "metadata_options" {
    for_each = var.create_metadata_options == true ? [var.metadata_options] : []
    content {
      http_endpoint               = lookup(metadata_options.value, "http_endpoint", null)
      http_tokens                 = lookup(metadata_options.value, "http_tokens", null)
      http_put_response_hop_limit = lookup(metadata_options.value, "http_put_response_hop_limit", null)
    }
  }

  dynamic "monitoring" {
    for_each = var.create_monitoring == true ? var.monitoring : []
    content {
      enabled = var.enable_monitoring
    }
  }

  dynamic "network_interfaces" {
    for_each = var.create_network_interfaces == true ? var.network_interfaces : []
    content {
      associate_carrier_ip_address = lookup(network_interfaces.value, "associate_carrier_ip_address", null)
      associate_public_ip_address  = lookup(network_interfaces.value, "associate_public_ip_address", null)
      delete_on_termination        = lookup(network_interfaces.value, "delete_on_termination", null)
      description                  = lookup(network_interfaces.value, "description", null)
      device_index                 = lookup(network_interfaces.value, "device_index", null)
      ipv4_addresses               = lookup(network_interfaces.value, "ipv4_addresses", null) != null ? network_interfaces.value.ipv4_addresses : []
      ipv4_address_count           = lookup(network_interfaces.value, "ipv4_address_count", null)
      ipv6_addresses               = lookup(network_interfaces.value, "ipv6_addresses", null) != null ? network_interfaces.value.ipv6_addresses : []
      ipv6_address_count           = lookup(network_interfaces.value, "ipv6_address_count", null)
      network_interface_id         = lookup(network_interfaces.value, "network_interface_id", null)
      private_ip_address           = lookup(network_interfaces.value, "private_ip_address", "")
      security_groups              = lookup(network_interfaces.value, "security_groups", null) != null ? network_interfaces.value.security_groups : []
      subnet_id                    = lookup(network_interfaces.value, "subnet_id", null)
    }
  }

  dynamic "placement" {
    for_each = var.create_placement == true ? [var.placement] : []
    content {
      affinity          = lookup(placement.value, "affinity", null)
      availability_zone = lookup(placement.value, "availability_zone", null)
      group_name        = lookup(placement.value, "group_name", null)
      host_id           = lookup(placement.value, "host_id", null)
      spread_domain     = lookup(placement.value, "spread_domain", null)
      tenancy           = lookup(placement.value, "tenancy", null)
      partition_number  = lookup(placement.value, "partition_number", null)
    }
  }

  dynamic "tag_specifications" {
    for_each = var.create_tag_specifications == true ? var.tag_specifications : []
    content {
      resource_type = tag_specifications.value.resource_type
      tags          = tag_specifications.value.tags
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags_as_map
}




