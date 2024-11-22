# #############################################################################
# Terraform Module: Key Vault Store
# #############################################################################

module "naming" {
  source  = "TaleLearnCode/naming/azurerm"
  version = "0.0.2-pre"

  resource_type  = "key_vault"
  name_prefix    = var.name_prefix
  name_suffix    = var.name_suffix
  srv_comp_abbr  = var.srv_comp_abbr
  custom_name    = var.custom_name
  location       = var.location
  environment    = var.environment
}

resource "azurerm_key_vault" "key_vault" {
  name                       = module.naming.resource_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = var.tenant_id
  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.purge_protection_enabled
  sku_name                   = var.sku_name
  enable_rbac_authorization  = true
  tags                       = var.tags
}

resource "azurerm_role_assignment" "key_vault_administrators_all_access" {
  for_each            = length(var.all_access_users) > 0 ? toset(var.all_access_users) : toset([])
  scope               = azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Administrator"
  principal_id        = each.value

  depends_on = [
    azurerm_key_vault.key_vault
  ]
}

resource "azurerm_role_assignment" "key_vault_administrators" {
  for_each            = length(var.key_vault_administrators) > 0 ? toset(var.key_vault_administrators) : toset([])
  scope               = azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Administrator"
  principal_id        = each.value

  depends_on = [
    azurerm_key_vault.key_vault
  ]
}

resource "azurerm_role_assignment" "key_vault_secrets_offiers_all_access" {
  for_each            = length(var.all_access_users) > 0 ? toset(var.all_access_users) : toset([])
  scope               = azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id        = each.value

  depends_on = [
    azurerm_key_vault.key_vault
  ]
}

resource "azurerm_role_assignment" "key_vault_secrets_offiers" {
  for_each            = length(var.secrets_officers) > 0 ? toset(var.secrets_officers) : toset([])
  scope               = azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id        = each.value

  depends_on = [
    azurerm_key_vault.key_vault
  ]
}

resource "azurerm_role_assignment" "key_vault_secret_users" {
  for_each             = length(var.secret_users) > 0 ? toset(var.secret_users) : toset([])
  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Secret User"
  principal_id         = each.value

  depends_on = [
    azurerm_key_vault.key_vault
  ]
}