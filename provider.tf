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
  controller_ip = "52.71.215.202"
  username      = "admin"
  password      = ""
  version       = "2.20.1"
}
provider "aws" {
  region                  = "us-east-1"
  profile                 = "default"
  alias                   = "region_1"
  shared_credentials_file = "/Users/mohsinkamal/.aws/credentials"
}
