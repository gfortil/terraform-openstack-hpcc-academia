terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
  }

  backend "swift" {
    container         = "terraform-openstack-hpcc-academia-state"
    archive_container = "terraform-openstack-hpcc-academia-state-archive"
  }
}
/*
# Configure the OpenStack Provider
provider "openstack" {
  cloud = "./clouds.yaml"
}*/
