# ACR Outputs
output "acr_login_server" {
    description = "The URL that can be used to log into the container registry."
    value = azurerm_container_registry.acr.login_server
}

output "acr_admin_username" {
    description = "The Username associated with the Container Registry Admin account - if the admin account is enabled"
    value = azurerm_container_registry.acr.admin_username
}

output "acr_admin_password" {
    description = "The Password associated with the Container Registry Admin account - if the admin account is enabled."
    #sensitive = true
    value = nonsensitive(azurerm_container_registry.acr.admin_password)
}

# VM Outputs
#   Refs: https://developer.hashicorp.com/terraform/language/functions/nonsensitive
output "vm_public_ip_address" {
  value = "${azurerm_public_ip.myPublicIp1.ip_address}"
}
