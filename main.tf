module "transit_aws_1" {
  for_each = var.transit_data
  source   = "terraform-aviatrix-modules/aws-transit/aviatrix"
  version  = "v4.0.3"

  cidr          = each.value.cidr
  region        = each.value.region
  account       = each.value.account
  instance_size = each.value.instance_size
  name          = each.value.name
  ha_gw         = each.value.ha_gw
  insane_mode   = each.value.insane_mode
}
/*
module "transit-peering" {
  source  = "terraform-aviatrix-modules/mc-transit-peering/aviatrix"
  version = "1.0.4"

  transit_gateways = [
    module.transit_aws_1["east1"].transit_gateway.gw_name,
    module.transit_aws_1["west2"].transit_gateway.gw_name,
    module.transit_aws_1["apse2"].transit_gateway.gw_name

  ]

  excluded_cidrs = [
    "0.0.0.0/0"
  ]
  depends_on = [module.transit_aws_1]
}


################ Launch spoke GW in existing VPC with allocated eip ###################
data "aws_availability_zones" "az_available" {
  provider = aws.region_1
}

resource "aviatrix_spoke_gateway" "spoke_gateway_aws" {
  for_each                          = var.gw_data
  cloud_type                        = 1
  account_name                      = each.value.account
  gw_name                           = each.value.gw_name
  vpc_id                            = each.value.vpc_id
  vpc_reg                           = each.value.region
  gw_size                           = each.value.gw_size
  subnet                            = each.value.subnet
  eip                               = each.value.allocate_new_eip ? null : each.value.eip
  single_ip_snat                    = false
  enable_active_mesh                = true
  manage_transit_gateway_attachment = false
  ha_gw_size                        = each.value.ha ? each.value.gw_size : null
  ha_subnet                         = each.value.ha ? each.value.ha_subnet : null
  ha_eip                            = each.value.allocate_new_eip ? null : (each.value.ha ? each.value.ha_eip : null)
  insane_mode_az                    = each.value.hpe ? data.aws_availability_zones.az_available.names[0] : null
  ha_insane_mode_az                 = each.value.ha ? (each.value.hpe ? data.aws_availability_zones.az_available.names[1] : null) : null
  insane_mode                       = each.value.hpe
  allocate_new_eip                  = each.value.allocate_new_eip
  #enable_private_vpc_default_route  = each.value.enable_nat ? each.value.enable_private_vpc_default_route : null

}

resource "aviatrix_spoke_transit_attachment" "spoke_attachment" {
  for_each        = var.gw_data
  spoke_gw_name   = aviatrix_spoke_gateway.spoke_gateway_aws[each.key].gw_name
  transit_gw_name = join(",", (values({ for key, restr in module.transit_aws_1 : key => restr.transit_gateway.gw_name if restr.transit_gateway.vpc_reg == each.value.region })))

}
*/
##############SNAT To provide 0/0 in internet traffic#######
/*
resource "aviatrix_gateway_snat" "internet_snat" {
  for_each  = var.gw_data
  gw_name   = aviatrix_spoke_gateway.spoke_gateway_aws[each.key].gw_name
  snat_mode = "customized_snat"
  snat_policy {
    src_cidr = each.value.vpc_cidr

    dst_cidr = "0.0.0.0/0"


    interface  = "eth0"
    connection = "None"
    protocol   = "all"
    snat_ips   = aviatrix_spoke_gateway.spoke_gateway_aws[each.key].eip

    #exclude_rtb = ""
    #apply_route_entry = true
  }
  depends_on = [aviatrix_spoke_gateway.spoke_gateway_aws]
}


resource "aviatrix_gateway_snat" "internet_snat_ha" {
  for_each = {
    for key, restr in var.gw_data :
    key => restr if restr.ha
  }



  gw_name   = each.value.ha ? aviatrix_spoke_gateway.spoke_gateway_aws[each.key].ha_gw_name : null
  snat_mode = "customized_snat"
  snat_policy {
    src_cidr = each.value.vpc_cidr

    dst_cidr = "0.0.0.0/0"
    protocol = "all"

    interface  = "eth0"
    connection = "None"

    snat_ips = each.value.ha ? aviatrix_spoke_gateway.spoke_gateway_aws[each.key].ha_eip : null

    #exclude_rtb = ""
    #apply_route_entry = true

  }
  depends_on = [aviatrix_spoke_gateway.spoke_gateway_aws]
}
*/

resource "aviatrix_transit_external_device_conn" "site2cloud_affiliate_transit_east1" {
  for_each                  = var.remote_site
  connection_type           = each.value.connection_type
  custom_algorithms         = each.value.custom_algorithms
  phase_1_authentication    = each.value.custom_algorithms ? each.value.phase_1_authentication : null
  phase_2_authentication    = each.value.custom_algorithms ? each.value.phase_2_authentication : null
  phase_1_dh_groups         = each.value.custom_algorithms ? each.value.phase_1_dh_groups : null
  phase_2_dh_groups         = each.value.custom_algorithms ? each.value.phase_2_dh_groups : null
  phase_1_encryption        = each.value.custom_algorithms ? each.value.phase_1_encryption : null
  phase_2_encryption        = each.value.custom_algorithms ? each.value.phase_2_encryption : null
  pre_shared_key            = each.value.pre_shared_key
  vpc_id                    = join(",", (values({ for key, restr in module.transit_aws_1 : key => restr.transit_gateway.vpc_id if restr.transit_gateway.vpc_reg == each.value.region })))
  connection_name           = each.value.connection_name
  gw_name                   = join(",", (values({ for key, restr in module.transit_aws_1 : key => restr.transit_gateway.gw_name if restr.transit_gateway.vpc_reg == each.value.region })))
  remote_gateway_ip         = each.value.remote_gateway_ip
  bgp_local_as_num          = each.value.connection_type == "bgp" ? var.bgp_as_num : null
  bgp_remote_as_num         = each.value.connection_type == "bgp" ? each.value.bgp_remote_as_num : null
  local_tunnel_cidr         = each.value.local_tunnel_cidr
  remote_tunnel_cidr        = each.value.remote_tunnel_cidr
  ha_enabled                = each.value.ha_enabled
  backup_remote_gateway_ip  = each.value.ha_enabled ? each.value.backup_remote_gateway_ip : null
  backup_bgp_remote_as_num  = each.value.ha_enabled ? each.value.backup_bgp_remote_as_num : null
  backup_pre_shared_key     = each.value.ha_enabled ? each.value.backup_pre_shared_key : null
  backup_local_tunnel_cidr  = each.value.ha_enabled ? each.value.backup_local_tunnel_cidr : null
  backup_remote_tunnel_cidr = each.value.ha_enabled ? each.value.backup_remote_tunnel_cidr : null
  #enable_single_ip_ha       = false

}
/*
#############Test infra to be deleted #############

resource "aviatrix_vpc" "aws_vpc" {
  cloud_type           = 1
  account_name         = "avxacc"
  region               = "us-east-1"
  name                 = "aws-vpc"
  cidr                 = "10.0.0.0/16"
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
}
resource "aviatrix_vpc" "aws_vpc2" {
  cloud_type           = 1
  account_name         = "avxacc"
  region               = "us-east-2"
  name                 = "aws-vpc-2"
  cidr                 = "10.28.0.0/16"
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
}
*/
