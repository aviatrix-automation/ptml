terraform {
  required_providers {

    aviatrix = {
      source  = "AviatrixSystems/aviatrix"
      version = "2.20.0"
    }
  }
}
provider "aviatrix" {
  controller_ip = "52.71.215.202"
  username      = "admin"
  password      = "Aviatrix123#"
  version       = "2.20.0"
}
