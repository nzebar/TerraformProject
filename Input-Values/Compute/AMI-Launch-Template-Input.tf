module "AMI_VPC1" {
    source = "../../Modules/Compute-Modules/Default-Modules/Launch-Template-Modules"

####################
## Create New AMI ##
####################

create_new_ami = true
ami_name = "AMI_001"
ami_description = "This is the first AMI created for the launch template"
root_device_name = "/dev/xvda"
architecture = "x86_64"
enhanced_networking_support = false

virtualization_type = "hvm"
virtualization_settings = {
    # hvm virtualization type
    sriov_net_support = "simple"
    # paravirtual virtualization type 
    image_location = "" # Required
    kernal_id = "" # Required
    ramdisk_id = ""
}

ebs_block_devices = {
    ebs_1 = {
      # Existing EBS Device Settings
        existing_snapshot_id = ""

      # New EBS Block Device Settings
        use_new_snapshot = true # Creates empty EBS for snapshot id
        ebs_key = "ebs_1" # Key identifier for this EBS instance. Must be unique
        availability_zone = "us-east-1a"
        ebs_tags = {"ebs" = "ebs_1"}
        snapshot_tags = {}

      # EBS Block Device Settings
        device_name = "/dev/xvda"
        volume_type = "gp2"
        volume_size = 10
        iops = 500
        throughput = 125
        delete_on_termination = false
    }
  }

ephemeral_block_devices = {
    # eph_1 = {
    #     device_name = "AMI_001_EPH_001"
    #     virtual_name = ""
    # }
}

timeouts = {}

create_ami_launch_permissions = false
ami_launch_permissions = {
  perm1 = {
    account_id = "34551111"
  }
}

ami_tags = {
    "AMI" = "AMI_001"
}



#####################
## Launch Template ##
#####################

  create_lt = true
  lt_name = "AMI_001_Launch_Template"
  lt_use_name_prefix = false
  lt_description = "This is the launch template for AMI 001"

## VERSION SETTINGS ## 

# update_default_version               = false
  default_version                      = 1 

## AMI SETTINGS ##

  use_new_ami      = true
  use_existing_ami_id = "" # Leave "" for null
  copy_ami = {
    enable = false
    name              = ""
    description       = ""
    source_ami_id     = ""
    source_ami_region = ""
    encrypted = true
    kms_key_id = "" # Null if create_new_kms_key == true
    create_new_kms_key = true
    new_kms_key_settings = {
      values = {
          description = "This is the KMS key for the copied AMI for the launch template"
          is_enabled = true
          policy = ""
          enable_key_rotation = true
          deletion_window_in_days = 30
          tags = { "AMI_KEYS" = "AMI_KEY_1" }
      }
    }
    tags = {
        "key" = "value"
    }
  } 
  copy_instance_ami = { # Instance will experience downtime if running
    enable = false
    name = ""
    source_instance_id = ""
  }

## PRICE MANAGEMENT SETTINGS ##

  create_instance_market_options = false
  instance_market_options = {
    market_option_values = {
      market_type = ""
      create_spot_options = false
      spot_options = {
        spot_option_values = {
            block_duration_minutes = 0
            instance_interruption_behavior = ""
            max_price = ""
            spot_instance_type = ""
            valid_until = ""
            }
        }
    }
  }

  create_license_specifications = false
  license_specifications = {
    license_1 = {
        license_configuration_arn = ""
    }
  }

## INSTANCE SETTINGS ##

  instance_type = "t2.micro"
  kernel_id                            = ""
  ram_disk_id                          = ""

  user_data_local_file_path = "Input-Values\\Compute\\Scripts\\Docker-Agent-Install.sh" # Leave "" for null

  create_metadata_options = false
  metadata_options = {
    values = {
      http_endpoint = ""
      http_tokens = ""
      http_put_response_hop_limit = 1
    }
  }

  create_placement = false
  placement = {
    values = {
      affinity          = ""
      availability_zone = ""
      group_name        = ""
      host_id           = ""
      spread_domain     = ""
      tenancy           = ""
      partition_number  = 0
    }
  }

  create_capacity_reservation_specification = false
  capacity_reservation_specification = {
    values = {
        capacity_reservation_preference = ""
        capacity_reservation_target = {
            capacity_reservation_id = ""
        }
    }
  }

  create_hibernation_options = false
  hibernation_options = {
    configured = false
  }

  instance_initiated_shutdown_behavior = "stop"

## CPU SETTINGS ##

  create_cpu_options = false
  cpu_options = {
    core_count = 1
    threads_per_core = 2
  }

  create_credit_specification = false
  credit_specification = {
    cpu_credits = "standard"
  }

## GPU SETTINGS ##

  create_elastic_gpu_specifications = false
  elastic_gpu_specifications = {
    type = ""
  }

  create_elastic_inference_accelerator = false
  elastic_inference_accelerator = {
    type = ""
  }

## EBS SETTINGS ##

  ebs_optimized = false
  manage_block_device_mappings = true
  block_device_mappings = {
    mapping_1 = {
        device_name  = "/dev/xvdb"
        no_device    = ""
        virtual_name = ""
        ebs = {
          snapshot_id           = ""
          delete_on_termination = true 
          iops                  = 500
          throughput            = 125
          volume_size           = 10
          volume_type           = "gp2"
          encrypted             = true # null if snapshot_id != ""
          kms_key_id            = "" # null if snapshot_id != ""
          create_new_kms_key = true
          new_kms_key_settings = {
            description = "AMI_001_EBS_001 KMS key" # Desc for each new KMS key must be unique
            is_enabled = true
            policy = ""
            enable_key_rotation = false
            deletion_window_in_days = 22
            tags = { "AMI_001_KEYS" = "AMI_001_EBS_001_KEY_001" }
          }
        }
     }
  }

## NETWORKING SETTINGS ##

  disable_api_termination              = false

  create_network_interfaces = true
  network_interfaces = {
    interface_1 = {
      description                  = "Network Interface 1" # Description for each interface must be unique
  
      existing_network_interface_id = ""
      new_network_interface = true

    # Network Interface Settings
      subnet_id                    = module.AMI_VPC1.public_subnet_1.id
      associate_carrier_ip_address = false
      associate_public_ip_address  = false
      ipv4_addresses               = ["192.168.1.8", "192.168.1.9"]
      primary_private_ip_address   = "192.168.1.8"
      ipv4_address_count           = 0 # Null if ipv4 addresses != 0
      ipv6_addresses               = []
      ipv6_address_count           = 0 # Null if ipv6_addresses != 0
      source_dest_check = true
      interface_type = "interface" # interface || EFA
      device_index                 = 0

    # Network Interface Security Groups
      existing_security_groups              = []
      use_new_security_groups = ["Launch_Template_Security_Group_1"]

      delete_on_termination        = false
    }
  }

## SECURITY/MONITORING SETTINGS ##

  use_new_security_groups = []
  existing_security_group_ids = []

  key_name      = "AMI_001_PUB_KEY"

  create_iam_instance_profile = false
  iam_instance_profile = {
      name = ""
      arn = ""
  }

  create_enclave_options = false
  enclave_options = {
    enabled = false
  }

  create_monitoring = false
  monitoring = {
    enabled = false
  }

## LAUNCH TEMPLATE TAG SETTINGS ##

  create_tag_specifications = false
  tag_specifications = {
    values = {
      resource_type = ""
      tags = {
        "key" = "value"
      }
    }
  }

  launch_template_tags = {
    "Launch_Template" = "LT_001_AMI_001"
  }

#####################################
## Launch Template Security Groups ##
#####################################

create_launch_template_security_groups = true

launch_template_security_groups = {

    Launch_Template_Security_Group_1 = { 
        name        = "Web Security Group"
        description = "This is the SecGrp for web instances" 
        vpc_id      = module.AMI_VPC1.vpc.id

        ingress_rules = { 
            rule_1 = {
                description      = "ingress_yuh" 
                from_port        = 0 
                to_port          = 0 
                protocol         = "-1" 
                cidr_blocks      = ["0.0.0.0/0"] 
                ipv6_cidr_blocks = []   
                self = false  
            }
        }

        egress_rules = {  
            rule_1 = {
                description      = "egress_yuh" 
                from_port        = 0 
                to_port          = 0 
                protocol         = "-1" 
                cidr_blocks      = ["0.0.0.0/0"] 
                ipv6_cidr_blocks = []   
                self = false  
            }
        }

        tags = {
            "Security_Group" = "WEB_SERVER" 
        }
    }

}

}

















