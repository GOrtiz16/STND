resource "azurerm_resource_group" "rg_all" {
  location = var.location
  name     = var.resource_group_name_all
}

resource "azurerm_resource_group" "rg_seguridad" {
  location = var.location
  name     = var.resource_group_name_seguridad
}


