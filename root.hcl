locals {
  organization = get_env("TERRAFORM_ORG_NAME")
  workspace_tags = get_env("TERRAFORM_WORKSPACE_TAGS")
}


generate "backend" {
  path      = "auto_generated_backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  cloud {
    organization = "${local.organization}"
    workspaces {
      tags = ["${local.workspace_tags}"]
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
EOF
}
