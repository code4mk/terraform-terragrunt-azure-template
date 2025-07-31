locals {
  common_tags = {
    "Environment" = "prod",
    "ProvisionedBy"  = "Terraform"
  }
}

provider "azurerm" {
  features {}
}


module "resource_group" {
  source = "./modules/resource_group"

  name     = var.resource_group_name
  location = var.resource_group_location
  tags     = merge(var.resource_group_tags, local.common_tags)
}