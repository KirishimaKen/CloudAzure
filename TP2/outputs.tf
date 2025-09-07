output "vm_public_ip" {
  description = "Adresse IP publique de la VM"
  value       = azurerm_public_ip.main.ip_address
}

output "vm_dns_name" {
  description = "Nom DNS associé à la VM"
  value       = azurerm_public_ip.main.fqdn
}

output "secret" {
  description = "Valeur secret"
  value       = random_password.jacques_secret.result
  sensitive   = true
}