locals {
  tags = {
    Environment = "Test"
    Department  = "Personal"
    Owner       = "John"
  }
}


module "rg" {
  source   = "../../../Modules/resource-group"
  rg_name  = "${var.prefix}-gwen-rg"
  location = var.location
  tags     = local.tags
}

resource "random_integer" "resource_code" {
  min = 1234
  max = 9999
}

module "cosmosdb" {
  source              = "../../../Modules/cosmosdb-account"
  db_name                = "azureresume-cosmosdb-${random_integer.resource_code.result}"
  location            = module.rg.location
  resource_group_name = module.rg.resource_group

  tags                = local.tags
}