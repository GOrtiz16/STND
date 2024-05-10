
resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = var.resource_group_name_aks
}

resource "azurerm_resource_group" "rg02" {
  location = var.location
  name     = var.resource_group_name_aks_secondary
}
