terraform {
  required_version = "~> 1.3"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.3.0"
    }
    rke = {
      source  = "rancher/rke"
      version = "1.3.4"
    }
  }

  cloud {
    organization = "jdfant"
    workspaces {
      name = "CLI"
    }
  }
}

provider "local" {}

provider "rke" {
  debug    = true
  log_file = "rke_debug.log"
}
