terraform {
  required_providers {

    aviatrix = {
      source  = "AviatrixSystems/aviatrix"
      version = "2.20.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "3.64.2"

    }
  }
}
provider "aviatrix" {
  controller_ip = ""
  username      = "admin"
  password      = "Aviatrix123#"
  version       = "2.20.1"
}
provider "aws" {
  region                  = "us-east-1"
  profile                 = "default"
  alias                   = "region_1"
  shared_credentials_file = "/Users/mohsinkamal/.aws/credentials"
}
