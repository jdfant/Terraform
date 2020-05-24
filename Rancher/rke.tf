provider "rke" {
  log_file = var.rke_log
}

resource "local_file" "ca_crt" {
  filename = var.cluster_ca_cert
  content  = rke_cluster.cluster.ca_crt
}

resource "local_file" "client_cert" {
  filename = var.cluster_tls_cert
  content  = rke_cluster.cluster.client_cert
}

resource "local_file" "client_key" {
  filename = var.cluster_tls_key
  content  = rke_cluster.cluster.client_key
}

resource rke_cluster "cluster" {
  depends_on            = [null_resource.remote-exec]
  provider              = rke
  ssh_agent_auth        = false
  ignore_docker_version = false

  nodes {
    address          = var.node_ip[0]
    internal_address = var.node_ip[0]
    user             = var.users[1]
    role             = ["controlplane", "worker", "etcd"]
    ssh_key          = file(var.private_ssh_key)
  }

  nodes {
    address          = var.node_ip[1]
    internal_address = var.node_ip[1]
    user             = var.users[1]
    role             = ["controlplane", "worker", "etcd"]
    ssh_key          = file(var.private_ssh_key)
  }

  nodes {
    address          = var.node_ip[2]
    internal_address = var.node_ip[2]
    user             = var.users[1]
    role             = ["controlplane", "worker", "etcd"]
    ssh_key          = file(var.private_ssh_key)
  }

  services {
    etcd {
      backup_config {
        interval_hours = 6
        retention      = 24
      }
    }
  }

  authentication {
    strategy = "x509"
  }

  authorization {
    mode = "rbac"
  }

  ingress {
    provider = "nginx"
    options = {
      use-forwarded-headers = true
    }
  }
}

resource "local_file" "kube_cluster_yaml" {
  filename = "${path.root}/kube_config_cluster.yml"
  content  = rke_cluster.cluster.kube_config_yaml

  provisioner "local-exec" {
    command = "cp kube_config_cluster.yml ~/.kube/config"
  }
}
