terraform {
  source = "../../live//dev"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name     = "rg-dev"
  resource_group_location = "eastus"
  resource_group_tags     = {
    "Environment" = "dev",
    "ProvisionedBy"  = "Terraform"
  }
}
