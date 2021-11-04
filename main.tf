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
