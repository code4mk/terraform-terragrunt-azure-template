# terraform-terragrunt-azure-project

A Terraform and Terragrunt project for managing Azure infrastructure across multiple environments (dev, stage, prod).

# Directory Structure

- `modules/` — Reusable Terraform modules (`vpc`, `subnet`, etc.)
- `live/` - Terraform related code per environment
  - `common/` — Shared code across all environments
  - `dev/`, `stage/`, `prod/` — Environment-specific code
    - `modules/` — Symlinks to root-level modules
    - `common-*.tf` — Symlinks to shared `common` configs
- `environment/` — Contains per-environment `terragrunt.hcl` config
- `root.hcl` — Root-level configuration used by all environments
- `scripts/` — Utility scripts for setting up symlinks and running terragrunt

# File structure

```bash
terraform-terragrunt-azure-project/
├── README.md                     # Project overview, usage, prerequisites, etc.
├── azure.md                      # Azure-specific notes or instructions
├── config.json                   # Optional config or metadata (not used by Terraform)
├── root.hcl                      # Root Terragrunt configuration for all environments

├── environment/                  # Terragrunt environment configs
│   ├── dev/
│   │   └── terragrunt.hcl        # Dev environment-specific Terragrunt config
│   ├── stage/
│   │   └── terragrunt.hcl        # Stage environment-specific Terragrunt config
│   └── prod/
│       └── terragrunt.hcl        # Prod environment-specific Terragrunt config
├── live/                         # Terraform environment code (per workspace)
│   ├── common/                   # Shared Terraform code (e.g., tags, providers)
│   │   └── common-resources.tf   # Common code to be symlinked
│
│   ├── dev/
│   │   ├── common-*.tf           # Symlinked common tf files
│   │   ├── main.tf               # Entry point for Terraform resources
│   │   ├── variables.tf          # Input variables
│   │   ├── output.tf             # Output variables
│   │   └── modules/              # Symlinked modules
│   │       └── resource_group
│
│   ├── stage/
│   │   ├── common-*.tf
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── output.tf
│   │   └── modules/             # Symlinked modules
│   │       └── resource_group
│
│   └── prod/
│       ├── common-*.tf           # Symlinked common tf files
│       ├── main.tf
│       ├── variables.tf
│       ├── output.tf
│       └── modules/             # Symlinked modules
│           └── resource_group
├── modules/                      # Reusable Terraform modules
│   └── resource_group/           # Resource group module
│       ├── main.tf
│       ├── output.tf
│       └── variables.tf
└── scripts/                      # Automation utilities
    ├── run.sh                    # Example: wrapper to run Terragrunt/Terraform
    ├── symlink-common.sh         # Script to symlink common tf files into each env
    └── symlink-modules.sh        # Script to symlink shared modules into each env
```

---

# Prerequisites

- Terraform
- Terragrunt
- Azure CLI
- Azure Subscription

* Before installation terrafrom and terragrunt, check the [Terragrunt and Terraform version Compatibility](https://terragrunt.gruntwork.io/docs/reference/supported-versions/#supported-terraform-versions)


# Setup

## 1. add symlink for modules and common files
```bash
./scripts/symlink-modules.sh
./scripts/symlink-common.sh
```

## 2. add .env file to the root of the project

```bash
TERRAFORM_ORG_NAME=your-org-name
TERRAFORM_WORKSPACE_TAGS=your-workspace-tags
```

## 3. update config.json file

```json
{
  "terraform_version": "1.8.0",
  "terragrunt_version": "0.57.0",
  "environments": {
    "main": {
      "TF_WORKSPACE": "infra-azure-prod",
      "TG_WORKDIR": "environment/prod"
    },
    "stage": {
      "TF_WORKSPACE": "infra-azure-stage",
      "TG_WORKDIR": "environment/stage"
    },
    "dev": {
      "TF_WORKSPACE": "infra-azure-dev",
      "TG_WORKDIR": "environment/dev"
    },
    "default": {
      "TF_WORKSPACE": "default",
      "TG_WORKDIR": "environment/default"
    }
  }
}
```


## 4. Add azure environment variables in terraform cloud workspace

### Environment Variables:

* `ARM_CLIENT_ID` = Your Service Principal App ID
* `ARM_CLIENT_SECRET` = Your Service Principal Password (mark as sensitive)
* `ARM_SUBSCRIPTION_ID` = Your Azure Subscription ID
* `ARM_TENANT_ID` = Your Azure Tenant ID

### Create Service Principal

```bash
# Login to Azure
az login

# Create Service Principal
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<your-subscription-id>" --name="terraform-sp"
```

## 5. run terragrunt with the following command
```bash
./scripts/run.sh
```

# Run GitHub Action (Terragrunt Plan and Apply)

## Setting Up GitHub Secrets

To ensure that the GitHub Action workflow runs correctly, you need to set up the following GitHub secret and variables:

### Secrets:
- **`TF_API_TOKEN`**: This is a Terraform Cloud API token used for authentication.

### Variables:
- **`TERRAFORM_ORG_NAME`**: This is the name of the Terraform Cloud organization.
- **`TERRAFORM_WORKSPACE_TAGS`**: This is the tags of the Terraform Cloud workspace.

## Update Config File

The `config.json` file contains essential configurations for Terraform and Terragrunt. You should update this file to match your environment and branch-specific settings.

### Config File Structure

Here is the format for `config.json`:

```json
{
  "terraform_version": "1.8.0",
  "terragrunt_version": "0.57.0",
  "environments": {
    "main": {
      "TF_WORKSPACE": "infra-azure-prod",
      "TG_WORKDIR": "environment/prod"
    },
    "stage": {
      "TF_WORKSPACE": "infra-azure-stage",
      "TG_WORKDIR": "environment/stage"
    },
    "dev": {
      "TF_WORKSPACE": "infra-azure-dev",
      "TG_WORKDIR": "environment/dev"
    },
    "default": {
      "TF_WORKSPACE": "default",
      "TG_WORKDIR": "environment/default"
    }
  }
}
```

> [!NOTE]
> This project intentionally uses a minimal set of Terragrunt features, primarily focusing on environment variable management and configuration inheritance. This approach keeps the infrastructure code simple and maintainable while still leveraging Terragrunt's key benefits for managing multi-environment deployments.

---

## 💼 Professional Services

### Need Help with Your Infrastructure?

I'm available for hire to help with your Terraform, Terragrunt, and Azure infrastructure projects.

**Services offered:**
- Infrastructure as Code (IaC) development
- Azure cloud architecture and deployment
- Terraform/Terragrunt consulting and best practices
- CI/CD pipeline setup and optimization
- Infrastructure troubleshooting and optimization

**📧 Contact:** hiremostafa@gmail.com

---


