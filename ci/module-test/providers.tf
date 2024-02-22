# Terraform configuration

terraform {
  required_providers {
    solacebroker = {
      source = "registry.terraform.io/solaceproducts/solacebroker"
    }
  }
  required_version = "~> 1.2"
}
