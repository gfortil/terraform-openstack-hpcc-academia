terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
  }

  backend "swift" {
        container   = "hpcc-academia-volume-terraform-state"
        archive_container = "hpcc-academia-volume-terraform-state-archive"
    }
}

