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