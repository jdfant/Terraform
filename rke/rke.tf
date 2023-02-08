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

      extra_args = {
        listen-metrics-urls = "http://0.0.0.0:2381"
      }
    }

    kubelet {
      cluster_domain               = "cluster.jd"
      fail_swap_on                 = false
      generate_serving_certificate = false
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

###############################################################################
# If you need ca_crt/client_cert/client_key, please uncomment follows.
###############################################################################
#resource "local_file" "ca_crt" {
#  filename = "${path.root}/ca_cert"
#  content  = rke_cluster.cluster.ca_crt
#}
#
#resource "local_file" "client_cert" {
#  filename = "${path.root}/client_cert"
#  content  = rke_cluster.cluster.client_cert
#}
#
#resource "local_file" "client_key" {
#  filename = "${path.root}/client_key"
#  content  = rke_cluster.cluster.client_key
#}
