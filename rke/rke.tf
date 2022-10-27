resource "rke_cluster" "jd" {
  kubernetes_version    = var.kubernetes_version
  ignore_docker_version = var.ignore_docker_version

  dynamic "nodes" {
    for_each = var.nodes
    content {
      hostname_override = nodes.value.hostname_override
      address           = nodes.value.address
      internal_address  = nodes.value.internal_address
      user              = nodes.value.user
      role              = nodes.value.role
      port              = nodes.value.port
      docker_socket     = nodes.value.docker_socket
      ssh_agent_auth    = nodes.value.ssh_agent_auth
      ssh_key           = file("~/.ssh/rke")
    }
  }

  network {
    plugin = "canal"
  }

  authentication {
    strategy = "x509"
  }

  authorization {
    mode    = "rbac"
    options = {}
  }

  services {
    etcd {
      snapshot  = true
      creation  = "6h"
      retention = "24h"
    }
  }

  ingress {
    provider = "nginx"
    options = {
      use-forwarded-headers = true
    }
  }

  upgrade_strategy {
    drain                  = true
    max_unavailable_worker = "20%"

    drain_input {
      ignore_daemon_sets = true
      delete_local_data  = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "local_file" "kube_cluster_yaml" {
  filename = format("%s/%s", path.root, "kube_config_cluster.yml")
  content  = rke_cluster.jd.kube_config_yaml

  provisioner "local-exec" {
    command    = <<EOT
      echo "Updating ~/.kube/config file"
      cp kube_config_cluster.yml ~/.kube/config
      sleep 10
    EOT
    on_failure = continue
  }

   lifecycle {
     ignore_changes = [content]
   }
}
