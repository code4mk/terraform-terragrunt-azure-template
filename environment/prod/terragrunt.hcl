terraform {
  source = "../../live//prod"
}

# Include the root.hcl file
include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  environment = "prod"
  project_name = "Your project name"
}

# Define the inputs for the module
inputs = {
  resource_group_name     = "rg-prod"
  resource_group_location = "eastus"
  resource_group_tags     = {
    "ProjectName" = local.project_name
  }
}
