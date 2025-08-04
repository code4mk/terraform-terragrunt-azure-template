terraform {
  source = "../../live//dev"
}

# Include the root.hcl file
include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  environment = "dev"
  project_name = "Your project name"
}

# Define the inputs for the module
inputs = {
  environment             = local.environment
  
  resource_group_name     = "rg-dev"
  resource_group_location = "eastus"
  resource_group_tags     = {
    "ProjectName" = local.project_name
  }
}
