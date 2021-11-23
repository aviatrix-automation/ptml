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

gw_data = {
  ptus1 = {
    account          = "avxacc"
    vpc_id           = "vpc-0fd446149fbce7cc0"
    region           = "us-east-1"
    gw_size          = "t3.small"
    subnet           = "10.0.96.0/20"
    ha_subnet        = "10.0.112.0/20"
    eip              = "52.73.120.87"
    ha_eip           = "35.173.46.191"
    gw_name          = "test-spoke"
    ha               = true
    hpe              = false
    allocate_new_eip = false
    vpc_cidr         = "10.0.0.0/16" #needed to create the snat entry
    #transit          = "avx-ptml-east1-transit"
  }

  ptus2 = {
    account   = "avxacc"
    vpc_id    = "vpc-09a22c274c6464371"
    region    = "us-east-2"
    gw_size   = "t3.small"
    subnet    = "10.28.48.0/20"
    ha_subnet = "10.28.64.0/20"
    #eip         = "52.73.120.87"
    #ha_eip      = "35.173.46.191"
    gw_name          = "test-spoke-2"
    ha               = true
    hpe              = false
    allocate_new_eip = true
    vpc_cidr         = "10.28.0.0/16"
    transit          = "avx-ptml-west2-transit"
    #enable_private_vpc_default_route = false
    enable_nat = false
  }

}
remote_site = {
  site1 = {
    remote_gateway_ip  = "3.224.101.190"
    bgp_remote_as_num  = "65444"
    local_tunnel_cidr  = "169.254.76.17/30,169.254.76.21/30"
    remote_tunnel_cidr = "169.254.76.18/30,169.254.76.22/30"
    connection_type    = "bgp"
    custom_algorithms  = false
    pre_shared_key     = "LxTnuN1kjZKtnfTrcYuLaw6HMyORTfp5eATMIr3n"
    connection_name    = "transit-east-affliate"
    ha_enabled         = false
    region             = "us-east-1"
  }
  /*
  site2 = {
    ha_enabled             = false
    remote_gateway_ip      = "1.2.3.8"
    bgp_remote_as_num      = "65444"
    local_tunnel_cidr      = "169.254.76.26/30,169.254.76.32/30"
    remote_tunnel_cidr     = "169.254.76.27/30,169.254.76.33/30"
    connection_type        = "bgp"
    custom_algorithms      = true
    phase_1_authentication = "SHA-256"
    phase_2_authentication = "HMAC-SHA-256"
    phase_1_dh_groups      = "14"
    phase_2_dh_groups      = "14"
    phase_1_encryption     = "AES-256-CBC"
    phase_2_encryption     = "AES-256-CBC"
    pre_shared_key         = "LxTnuN1kjZKtnfTrcYuLaw6HMyORTfp5eATMIr3n"
    connection_name        = "transit-east-affliate2"
  }
  */
}
bgp_as_num = "5678"
