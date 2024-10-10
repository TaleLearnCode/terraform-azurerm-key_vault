# #############################################################################
# Outputs
# #############################################################################

output "key_vault" {
  value = azurerm_key_vault.key_vault
  description = "The Key Vault resource."
}