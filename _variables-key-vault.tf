# #############################################################################
# Variables: Key Vault
# #############################################################################

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group in which the Key Vault will be created."
}

variable "tenant_id" {
  type        = string
  default     = "8c5ae8ec-a067-485b-bc71-5d47eb639670"
  description = "The Azure Active Directory tenant identifier that should be used for authenticating requests to the key vault. Default is the Jasper tenant identifier."
}

variable "soft_delete_retention_days" {
  type        = number
  default     = 7
  description = "The number of days that items should be retained for once soft-deleted. This value can be between 7 (the default) and 90 days."
}

variable "purge_protection_enabled" {
  type        = bool
  default     = false
  description = "Is Purge Protection enabled for this Key Vault. Default is false."
}

variable "sku_name" {
  type        = string
  default     = "standard"
  description = "The name of the SKU used for this Key Vault. Possible values are 'standard' and 'premium'."
}