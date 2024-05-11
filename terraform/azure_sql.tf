resource "azurerm_mssql_server" "sqlServer" {
  name                         = var.sqlServer_name
  resource_group_name          = azurerm_resource_group.rg_all.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "admin123"
  administrator_login_password = "6EW5SSHR9BVt"
  minimum_tls_version          = "1.2"


}

resource "azurerm_mssql_database" "sqlDatabase" {
  name                 = var.sqlDatabase_name
  server_id            = azurerm_mssql_server.sqlServer.id
  collation            = local.database.collation
  license_type         = local.database.license_type
  max_size_gb          = local.database.max_size_gb
  read_scale           = local.database.read_scale
  sku_name             = local.database.sku_name
  zone_redundant       = local.database.zone_redundant
  storage_account_type = local.database.storage_account_type
  sample_name          = "AdventureWorksLT"

}


resource "azurerm_private_dns_zone" "az_sql_dns_zone" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.rg_all.name
}



resource "azurerm_private_endpoint" "az_sql_endpoint" {
  name                = "private-endpoint-sql"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_all.name
  subnet_id           = azurerm_subnet.sbnt01.id

  private_service_connection {
    name                           = "private-serviceconnection"
    private_connection_resource_id = azurerm_mssql_server.sqlServer.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  #   ip_configuration {
  #     name                          = "ip-config"
  #     private_ip_address            = "10.240.0.33"
  # }

  private_dns_zone_group {
    name                 = "dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.az_sql_dns_zone.id]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "az_sql_vnet_link" {
  name                  = "vnet-link"
  resource_group_name   = azurerm_resource_group.rg_all.name
  private_dns_zone_name = azurerm_private_dns_zone.az_sql_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet01.id
}