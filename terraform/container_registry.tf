resource "azurerm_container_registry" "acr" {
  name                          = replace(var.acr_name, "/[^a-zA-Z0-9]/", "")
  resource_group_name           = azurerm_resource_group.rg_all.name
  location                      = var.location
  sku                           = var.acr_sku
  admin_enabled                 = local.container_registry.admin_enabled
  public_network_access_enabled = local.container_registry.public_network_access_enabled


  network_rule_bypass_option = local.container_registry.network_rule_bypass_option

}

resource "azurerm_role_assignment" "enablePulling" {
  principal_id                     = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
  role_definition_name             = local.container_registry.role_definition_name
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = local.container_registry.skip_service_principal_aad_check
}

resource "azurerm_private_dns_zone" "acr" {
  name                = local.container_registry.dns_zone_name
  resource_group_name = azurerm_resource_group.rg_all.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "acr_vnet_link" {
  name                  = local.container_registry.virtual_network_link
  resource_group_name   = azurerm_resource_group.rg_all.name
  private_dns_zone_name = azurerm_private_dns_zone.acr.name
  virtual_network_id    = azurerm_virtual_network.vnet01.id
}

resource "azurerm_private_endpoint" "az_acr_endpoint" {
  name                = var.acr_private_endpoint_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_all.name
  subnet_id           = azurerm_subnet.sbnt01.id

  private_service_connection {
    name                           = local.container_registry.private_service_connection_name
    private_connection_resource_id = azurerm_container_registry.acr.id
    subresource_names              = [local.container_registry.subresource_names]
    is_manual_connection           = local.container_registry.is_manual_connection
  }

  private_dns_zone_group {
    name                 = local.container_registry.private_dns_zone_group
    private_dns_zone_ids = [azurerm_private_dns_zone.acr.id]
  }
}