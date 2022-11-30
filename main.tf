provider "azurerm"{
    version = "=3.0.1"
    features {}    
}

terraform {
  backend "azurerm" {
    resource_group_name = "tf_rg_blobstr"
    storage_account_name = "tfstract"
    container_name = "tfstatefilecotainer"
    key = "terraform.tfstate"
  }
  
}

resource "azurerm_resource_group" "tf_testrg"{
    name = "tfresorcerg"
    location = "East US"


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
    image  = "nagashreeshetty/newpythonwebapp:${var.imagetag}"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}



# # Create an App Service Plan with Linux
# resource "azurerm_app_service_plan" "appserviceplan" {
#   name                = "${azurerm_resource_group.tf_testrg}-plan"
#   location            = "${azurerm_resource_group.tf_testrg.location}"
#   resource_group_name = "${azurerm_resource_group.tf_testrg.name}"

#   # Define Linux as Host OS
#   kind = "Linux"
#   reserved = true
#   # Choose size
#   sku {
#     tier = "Standard"
#     size = "S1"
#   }

# #   properties {
# #     reserved = true # Mandatory for Linux plans
# #   }
# }

# locals {
#  env_variables = {
#    DOCKER_REGISTRY_SERVER_URL            = "https://hub.docker.com/u/nagashreeshetty"
#    DOCKER_REGISTRY_SERVER_USERNAME       = "nagashreeshetty"
#    DOCKER_REGISTRY_SERVER_PASSWORD       = "Dhanu@1003"
#  }
# }

# # Create an Azure Web App for Containers in that App Service Plan
# resource "azurerm_app_service" "newdockerapp" {
#   name                = "${azurerm_resource_group.tf_testrg.name}-dockerapp"
#   location            = "${azurerm_resource_group.tf_testrg.location}"
#   resource_group_name = "${azurerm_resource_group.tf_testrg.name}"
#   app_service_plan_id = "${azurerm_app_service_plan.appserviceplan.id}"

 

#   # Configure Docker Image to load on start
#   site_config {
#     linux_fx_version = "nagashreeshetty/newpythonwebapp"
#     always_on        = "true"
#   }
#   identity {
#     type = "SystemAssigned"
#   }

#    # Do not attach Storage by default
#   app_settings = locals.env_variables
  
#     /*
#     # Settings for private Container Registires  
#     DOCKER_REGISTRY_SERVER_URL      = ""
#     DOCKER_REGISTRY_SERVER_USERNAME = ""
#     DOCKER_REGISTRY_SERVER_PASSWORD = ""
#     */
  

# }
