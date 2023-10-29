#-----------------------------------------
# PROVIDERS
#-----------------------------------------
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
  }
  required_version = "~> 1.6"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

#-----------------------------------------
# VARIABLES
#-----------------------------------------

variable "registry_url" {
  description = "URL of your Docker registry (e.g., registry.example.com)"
  type        = string
  default     = "rg.fr-par.scw.cloud/smartfire-devops-tests"
}

variable "registry_secret_name" {
  description = "Docker registry secret"
  type        = string
  default     = "registry-secret"
}

variable "registry_password" {
  description = "Docker registry password"
  type        = string
  default     = ""
}

data "template_file" "docker_config" {
  template = <<-EOT
    {
      "auths": {
        "${var.registry_url}": {
          "password": "${var.registry_password}"
        }
      }
    }
  EOT
}

#-----------------------------------------
# KUBERNETES SECRETS
#-----------------------------------------

resource "kubernetes_secret" "docker_registry_secret" {
  metadata {
    name = var.registry_secret_name
  }

  data = {
    ".dockerconfigjson" = data.template_file.docker_config.rendered
  }
}

#-----------------------------------------
# KUBERNETES DEPLOYMENT APP
#-----------------------------------------



#-------------------------------------------------
# KUBERNETES DEPLOYMENT SERVICE
#-------------------------------------------------



#-------------------------------------------------
# KUBERNETES INGRESS
#-------------------------------------------------



#-------------------------------------------------
# KUBERNETES PVC
#-------------------------------------------------



#-------------------------------------------------
# KUBERNETES CONFIG MAPS
#-------------------------------------------------


