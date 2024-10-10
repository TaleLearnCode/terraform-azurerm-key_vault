# Example: Manage an Azure Key Vault

This module manages an Azure Key Vault using the [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest) Terraform provider.  This example shows how to use the module to manage an Azure Key Vault using a generated name that conforms with the Microsoft Cloud Adoption Framework.

## Example Usage

```hcl
locals {
  srv_comp_abbr = "eg"
  environment   = "dev"
  location      = "eastus"
  all_access_users = [ "00000000-0000-0000-0000-000000000000" ]
}

module "rg" {
  source  = "TaleLearnCode/resource_group/azurerm"
  version = "0.0.1-pre"
  providers = {
    azurerm = azurerm
  }

  srv_comp_abbr = local.srv_comp_abbr
  environment   = local.environment
  location      = local.location
}

module "kv" {
  source  = "TaleLearnCode/key_vault/azurerm"
  providers = {
    azurerm = azurerm
  }

  srv_comp_abbr               = local.srv_comp_abbr
  environment                 = local.environment
  location                    = local.location
  resoruce_group_name         = module.rg.resource_group.name
  all_access_users            = local.all_access_users
  depends_on = [
     module.rg
  ]
}
```

You are specifying three values:

- **srv_comp_abbr**: The abbreviation of the service or component for which the resources are being created for.
- **environment**: The environment where the resources are deployed to.
- **location**: The Azure Region in which all resources will be created.
- **resource_group_name**: The name of the Resource Group in which the Key Vault will be created.

> By convention, the module lower cases supplied name segments when generated the resource name.

This will result in an Azure Key Vault named: `kv-ILP-dev-usnc`.