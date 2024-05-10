 resource "azurerm_virtual_network" "vnet01" {
   name                = local.virtual_network.name
   resource_group_name = azurerm_resource_group.rg02
   location            = var.location
   address_space       = [local.virtual_network.address_space]
 }

 resource "azurerm_subnet" "sbnt01" {
   name                 = local.subnets.name
   resource_group_name  = azurerm_resource_group.rg02.name
   virtual_network_name = azurerm_virtual_network.vnet01.name
   address_prefixes     = [local.subnets.address_prefix]
}
