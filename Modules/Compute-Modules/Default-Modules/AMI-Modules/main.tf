################
## Create AMI ##
################

data "aws_ebs_snapshot" "ami_get_snapshot" {
  most_recent = true
  owners      = ["self"]
  snapshot_ids = ""

  filter {
    name   = "Tag:Name"
    values = [""]
  }
}

resource "aws_ami" "this_ami" {
  name                = "terraform-example"
  description = ""
  architecture = "86"
  virtualization_type = {
      image_location = ""
      kernal_id = ""
      ramdisk_id = ""
        # if condition
      sriov_net_support = ""
  }

  root_device_name    = "/dev/xvda"

  ebs_block_device {
    device_name = "/dev/xvda"
    delete_on_termination = bool
    encrypted = bool
    kms_key_id = "" # You can specify encrypted or snapshot_id but not both.
    volume_type = ""
    iops = "" # (Required only when volume_type is io1 or io2
    snapshot_id = "snap-xxxxxxxx"
    throughput = "" # Only valid for volume_type of gp3
    volume_size = number #Required unless snapshot_id is set
  }

  ephemeral_block_device {
      device_name = ""
      virtual_name = ""
  }

  timeouts {
    create = 40
    update = 40
    delete = 90
  }

  tags {

  }
}