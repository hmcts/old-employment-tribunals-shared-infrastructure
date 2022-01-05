module "tt-database" {
  source                = "git@github.com:hmcts/cnp-module-postgres?ref=master"
  product               = var.product
  component             = var.db_component_name
  location              = var.location
  env                   = var.env
  postgresql_user       = var.db_postgresql_user
  database_name         = var.db_name
  postgresql_version    = var.db_version
  common_tags           = var.common_tags
  subscription          = var.subscription
  storage_mb            = var.db_storage_mb
}

# Add DB outputs to keyvault

resource "azurerm_key_vault_secret" "tt-postgres-user" {
  name         = "tt-postgres-user"
  value        = module.tt-database.user_name
  key_vault_id = module.key-vault.key_vault_id
}

resource "azurerm_key_vault_secret" "tt-postgres-password" {
  name         = "tt-postgres-password"
  value        = module.tt-database.postgresql_password
  key_vault_id = module.key-vault.key_vault_id
}

resource "azurerm_key_vault_secret" "tt-postgres-host" {
  name         = "tt-postgres-host"
  value        = module.tt-database.host_name
  key_vault_id = module.key-vault.key_vault_id
}

resource "azurerm_key_vault_secret" "tt-postgres-port" {
  name         = "tt-postgres-port"
  value        = module.tt-database.postgresql_listen_port
  key_vault_id = module.key-vault.key_vault_id
}

resource "azurerm_key_vault_secret" "tt-postgres-database" {
  name         = "tt-postgres-database"
  value        = module.tt-database.postgresql_database
  key_vault_id = module.key-vault.key_vault_id
}