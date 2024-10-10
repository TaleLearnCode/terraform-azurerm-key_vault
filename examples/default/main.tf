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