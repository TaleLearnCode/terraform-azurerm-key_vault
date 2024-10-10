# #############################################################################
# Variables for the users that will be granted access to the key vault
# #############################################################################

variable "all_access_users" {
  type    = list(string)
  default = []
  description = "A list of user principal IDs that will be granted access to the key vault with all permissions."
}

variable "key_vault_administrators" {
  type    = list(string)
  default = []
  description = "A list of user principal IDs that will be granted access to the key vault as Key Vault Administrator."
}

variable "secrets_officers" {
  type    = list(string)
  default = []
  description = "A list of user principal IDs that will be granted access to the key vault as Key Vault Secrets Officer."
}