transit_data = {
  east1 = {
    region        = "us-east-1"
    account       = "avxacc"
    name          = "ptml-east1" #name will be avx-<name\>-transit.
    cidr          = "10.100.0.0/16"
    instance_size = "t3.small"
    #fw_instance_size     = "Standard_D3_v2"
    #insane_mode          = "false"
    #insane_instance_size = "Standard_D3_v2"
    #az_support           = "true"
    ha_gw       = "true"
    insane_mode = false
  }
  west2 = {
    region        = "us-west-2"
    account       = "avxacc"
    name          = "ptml-west2"
    cidr          = "10.101.0.0/16"
    instance_size = "t3.small"
    ha_gw         = "true"
    insane_mode   = false
  }
  apse2 = {
    region        = "ap-southeast-2"
    account       = "avxacc"
    name          = "ptml-southeast2"
    cidr          = "10.102.0.0/16"
    instance_size = "t3.small"
    ha_gw         = "true"
    insane_mode   = false
  }
}
