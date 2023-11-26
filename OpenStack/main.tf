terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.51.1"
    }
  }
}

// Configure the OpenStack Provider
provider "openstack" {
  user_name   = "<username>"
  tenant_name = "<tenant_name>"
  password    = "<password_account>"
  auth_url    = "<api_auth_openstack>"
  region = "<region_name>"
  domain_name = "<domain_name>"
}
