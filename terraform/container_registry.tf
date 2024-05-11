resource "azurerm_container_registry" "acr" {
  # name                = var.acr_name
  name                = replace(var.acr_name, "/[^a-zA-Z0-9]/", "")
  resource_group_name = azurerm_resource_group.rg_all.name
  location            = var.location
  sku                 = var.acr_sku
  admin_enabled       = false

}

resource "azurerm_role_assignment" "enablePulling" {
  principal_id                     = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

# resource "azurerm_private_dns_zone" "acr" {
#   name                = "privatelink.azurecr.io"
#   resource_group_name = azurerm_resource_group.rg_all.name
# }

# resource "azurerm_private_dns_zone_virtual_network_link" "acr_vnet_link" {
#   name                  = "acr-link"
#   resource_group_name   = azurerm_resource_group.rg_all.name
#   private_dns_zone_name = azurerm_private_dns_zone.acr.name
#   virtual_network_id    = azurerm_virtual_network.vnet01.id
# }

# resource "azurerm_private_endpoint" "az_acr_endpoint" {
#   name                = "private-endpoint-acr"
#   location            = var.location
#   resource_group_name = azurerm_resource_group.rg_all.name
#   subnet_id           = azurerm_subnet.sbnt01.id

#   private_service_connection {
#     name                           = "private-serviceconnection"
#     private_connection_resource_id = azurerm_container_registry.acr.id
#     subresource_names              = ["registry"]
#     is_manual_connection           = false
#   }

#   private_dns_zone_group {
#     name                 = "acr-dns-zone-group"
#     private_dns_zone_ids = [azurerm_private_dns_zone.acr.id]
#   }
# }