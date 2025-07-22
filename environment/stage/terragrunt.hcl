terraform {
  source = "../../live//stage"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name     = "rg-stage"
  resource_group_location = "eastus"
  resource_group_tags     = {
    "Environment" = "stage",
    "ProvisionedBy"  = "Terraform"
  }
}
