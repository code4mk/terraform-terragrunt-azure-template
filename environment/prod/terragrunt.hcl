terraform {
  source = "../../live//prod"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name     = "rg-prod"
  resource_group_location = "eastus"
  resource_group_tags     = {
    "Environment" = "prod",
    "ProvisionedBy"  = "Terraform"
  }
}
