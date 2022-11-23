provider "azurerm"{
    version = "=3.0.1"
    features {}    
}

resource "azurerm_resource_group" "tf_testrg"{
    name = "tfresorcerg"
    location = "East US"


}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_container_group" "tfazcontainergp" {
  name                = "az_docer_container"
  location            = azurerm_resource_group.tf_testrg.location
  resource_group_name = azurerm_resource_group.tf_testrg.name
  ip_address_type     = "Public"
  dns_name_label      = "welcomeweb"
  os_type             = "Linux"

  container {
    name   = "shreecontainer"
    image  = "${var.imagebuild}"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}