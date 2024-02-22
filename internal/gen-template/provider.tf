# Terraform configuration

terraform {
  required_providers {
    solacebroker = {
      source = "registry.terraform.io/solaceproducts/solacebroker"
      # TODO: auto-update version
      version = "~> 0.9"
    }
  }
}
