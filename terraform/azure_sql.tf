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
