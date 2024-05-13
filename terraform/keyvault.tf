data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "akv01" {
  #   name                          = var.keyvault_name
  name                          = replace(var.keyvault_name, "/[^a-zA-Z0-9]/", "")
  location                      = var.location
  resource_group_name           = azurerm_resource_group.rg_seguridad.name
  enabled_for_disk_encryption   = local.keyvault.enabled_for_disk_encryption
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days    = local.keyvault.soft_delete_retention_days
  public_network_access_enabled = local.keyvault.public_network_access_enabled
  purge_protection_enabled      = local.keyvault.purge_protection_enabled

  sku_name = local.keyvault.sku_name

  access_policy = [
    {
      application_id          = ""
      certificate_permissions = []
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_id               = azurerm_user_assigned_identity.identity.principal_id
      key_permissions = [
        "Get",
      ]
      secret_permissions = [
        "Get", "List"
      ]
      storage_permissions = [
        "Get",
      ]
    },
  ]

}



#----------------------------------------------------------

resource "azurerm_private_dns_zone" "akv" {
  name                = local.keyvault.dns_zone_name
  resource_group_name = azurerm_resource_group.rg_all.name
}

resource "azurerm_private_endpoint" "az_akv_endpoint" {
  name                          = var.akv_private_endpoint_name
  resource_group_name           = azurerm_resource_group.rg_all.name
  location                      = var.location
  subnet_id                     = azurerm_subnet.sbnt01.id
  custom_network_interface_name = local.keyvault.custom_network_interface_name

  private_service_connection {
    name                           = local.keyvault.private_service_connection_name
    private_connection_resource_id = azurerm_key_vault.akv01.id
    is_manual_connection           = local.keyvault.is_manual_connection
    subresource_names              = [local.keyvault.subresource_names]
  }

  private_dns_zone_group {
    name                 = local.keyvault.private_dns_zone_group
    private_dns_zone_ids = [azurerm_private_dns_zone.akv.id]
  }

  #   depends_on = [azurerm_subnet.akv_01, azurerm_private_dns_zone.akv_01]
}

resource "azurerm_private_dns_zone_virtual_network_link" "akv_vnet_link" {
  name                  = local.keyvault.virtual_network_link
  private_dns_zone_name = azurerm_private_dns_zone.akv.name
  virtual_network_id    = azurerm_virtual_network.vnet01.id
  resource_group_name   = azurerm_resource_group.rg_all.name
}