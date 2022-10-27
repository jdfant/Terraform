terraform {
  required_version = ">= 1.3"
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "~> 2.2.1"
    }
    rke = {
      source  = "rancher/rke"
      version = "1.3.3"
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
  log_file = "rke_debug.log"
}
