variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  default     = "East US"
  description = "Azure region"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM"
}

variable "public_key_path" {
  type        = string
  description = "Path to your SSH public key"
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
}

variable "ip_public" {
  type        = string
  description = "Public IP Connexion "
}

variable "storage_account_name" {
  type        = string
  description = "Storage Account Name"
}

variable "storage_container_name" {
  type        = string
  description = "Storage Container Name"
}

variable "alert_email_address" {
  type        = string
  description = "Email Address"
}

variable "vault_name" {
  type        = string
  description = "Vault Name"
}