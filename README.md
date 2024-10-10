# Azure Key Vault Terraform Module

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md)

This module manages Azure Key Vaults using the [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest) Terraform provider.


## Providers

| Name    | Version |
| ------- | ------- |
| azurerm | ~> 4.1. |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| Regions | TaleLearnCode/regions/azurerm | ~> .0.0.1-pre |

## Resources

No resources.

## Usage

```hcl
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

For more detailed instructions on using this module: please refer to the appropriate example:

- [Default](examples/default/README.md)

## Inputs

| Name                        | Description                                                  | Type    | Default            | Required |
| --------------------------- | ------------------------------------------------------------ | ------- | ------------------ | -------- |
| current_user_object_id      | The object identifier of the current user.                   | string  | N/A                | yes      |
| custom_name                 | If set, the custom name to use instead of the generated name. | string  | NULL               | no       |
| enable_rbac_authorization   | Boolean flag to specify whether the Key Vault uses Role Based Access Control (RBAC) for authorization. | Boolean | true               | no       |
| environment                 | The environment where the resources are deployed to. Valid values are `dev`, `qa`, `e2e`, and `prod`. | string  | N/A                | yes      |
| location                    | The Azure Region in which all resources will be created      | string  | N/A                | yes      |
| name_prefix                 | Optional prefix to apply to the generated name.              | string  | ""                 | no       |
| name_suffix                 | Optional suffix to apply to the generated name.              | string  | ""                 | no       |
| purge_protection_enabled    | Is Purge Protection enabled for this Key Vault.              | Boolean | false              | no       |
| resource_group_name         | The name of the Resource Group in which the Key Vault will be created. | string  | N/A                | yes      |
| service_principal_object_id | The object identifier of the service principal.              | string  | N/A                | yes      |
| sku_name                    | The name of the SKU used for this Key Vault.                 | string  | standard           | no       |
| soft_delete_retention_days  | The number of days that items should be retained for once soft-deleted. | number  | 7                  | no       |
| srv_comp_abbr               | The abbreviation of the service or component for which the resources are being created for. | string  | NULL               | no       |
| subscription_id             | The Azure Subscription Id to use for creating resources      | string  | N/A                | yes      |
| tags                        | A map of tags to apply to all resources.                     | map     | N/A                | no       |
| tenant_id                   | The Azure Active Directory tenant identifier that should be used for authenticating requests to the key vault. | string  | Jasper's Tenant Id | no       |

## Outputs

| Name           | Description                       |
|----------------|-----------------------------------|
| key_vault      | The managed Azure Key Vault.      |

### Key Vault

| Guideline                       |                                                              |
| ------------------------------- | ------------------------------------------------------------ |
| Resource Type Identifier        | kv                                                           |
| Scope                           | Global                                                       |
| Max Overall Length              | 3 - 24 characters                                            |
| Allowed Component Name Length * | 11 characters                                                |
| Valid Characters                | Alphanumeric and hyphens. Start with letter. End with letter or number. |
| Regex                           | ^(?!.*-{2}.*)([a-zA-Z][a-zA-Z0-9-]{1,22}[a-zA-Z0-9])$        |

* Allowed Component Name Length is a combination of the `srv_comp_abbr`, `name_prefix`, and `name_suffix` or the `custom_name` if used.