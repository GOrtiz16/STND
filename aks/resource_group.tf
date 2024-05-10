
resource "azurerm_resource_group" "rg_aks" {
  location = var.location
  name     = var.resource_group_name_aks
}

resource "azurerm_resource_group" "rg_aks_secondary" {
  location = var.location
  name     = var.resource_group_name_aks_secondary
}
