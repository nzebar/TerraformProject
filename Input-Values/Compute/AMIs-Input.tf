module "AMI_VPC1" {
    source = "../../Modules/Compute-Modules/Default-Modules/AMI-Modules"

##########    
## AMIs ##
##########
AMI = {
    AMI_1 = {
        name = ""
        description = ""
        root_device_name = ""
        architecture = "x86_64"
        ena_support = false

        virtualization_type = "hvm"
            sriov_net_support = "simple" # hbm virtualization type only
            image_location = "" # Paravirtual virtualization type only
            kernal_id = "" # Paravirtual virtualization type only
            ramdisk_id = "" # Paravirtual virtualization type only

        ebs_block_device = {
            ebs = {
                device_name = ""
               # snapshot_id = ""
                volume_type = "gp2"
                volume_size = 10
                iops = 500
                throughput = 100
                encrypted = true
               # kms_key_id = ""
                delete_on_termination = false
                }
            }

        ephemeral_block_device = {
            eph_1 = {
                device_name = "yuj"
                virtual_name = "yuh"
                }
            }

         create_timeouts = {
             timeouts = {
                }
            }

        tags = {
            "key" = "value"
        }
    }
}











}