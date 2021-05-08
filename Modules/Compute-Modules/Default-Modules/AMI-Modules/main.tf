################
## Create AMI ##
################

resource "aws_ami" "this_ami" {
for_each = var.AMI

  name = lookup(var.AMI[each.key], "AMI" , "") 
  description = lookup(var.AMI[each.key], "description" , "") 
  architecture = lookup(var.AMI[each.key], "architecture" , "") 
  virtualization_type = lookup(var.AMI[each.key], "virtualization_type" , "")
  image_location = lookup(var.AMI[each.key], "image_location", "" )
  kernel_id = lookup(var.AMI[each.key], "kernel_id", "" )
  ramdisk_id = lookup(var.AMI[each.key], "ramdisk_id", "" )
  sriov_net_support = lookup(var.AMI[each.key], "sriov_net_support", "" )

  root_device_name    = lookup(var.AMI[each.key], "root_device_name" , "")

  dynamic "ebs_block_device" {
    for_each = lookup(var.AMI[each.key], "ebs_block_device" , "")
    content {
    device_name = lookup(ebs_block_device.value, "device_name", "")
    delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", "")
    encrypted = lookup(ebs_block_device.value, "encrypted", "")
    #kms_key_id = lookup(ebs_block_device.value, "kms_key_id", "") # You can specify encrypted or snapshot_id but not both.
    volume_type = lookup(ebs_block_device.value, "volume_type", "")
    iops = lookup(ebs_block_device.value, "iops", "") # (Required only when volume_type is io1 or io2
    # snapshot_id = lookup(ebs_block_device.value, "snapshot_id", "" ) 
    throughput = lookup(ebs_block_device.value, "throughput", "") # Only valid for volume_type of gp3
    volume_size = lookup(ebs_block_device.value, "volume_size", "") #Required unless snapshot_id is set
    }
  }

  dynamic "ephemeral_block_device" {
    for_each = lookup(var.AMI[each.key], "ephemeral_block_device" , "")
    content {
      device_name = lookup(ephemeral_block_device.value, "device_name", "")
      virtual_name = lookup(ephemeral_block_device.value, "virtual_name", "")
    }
  }

  dynamic "timeouts" {
    for_each = lookup(var.AMI[each.key], "create_timeouts", {} )
    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = lookup(var.AMI[each.key], "tags", {} )
}