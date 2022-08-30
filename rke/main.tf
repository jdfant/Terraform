terraform {
  required_providers {
    rke = {
      source  = "rancher/rke"
      version = "~> 1.0"
    }
  }

  cloud {
    organization = "jdfant"
    workspaces {
      name = "CLI"
    }
  }
}

provider "rke" {
  log_file = "rke_debug.log"
}
