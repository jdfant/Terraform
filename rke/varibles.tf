variable "kubernetes_version" {
  description = "RKE Kubernetes version"
  type        = string
  default     = "v1.23.10-rancher1-1"
}

variable "cluster_domain" {
  description = "Cluster name"
  type        = string
  default     = "cluster.jd"
}

variable "ignore_docker_version" {
  description = "Flag to ignore Docker verion"
  type        = bool
  default     = true
}

variable "custom_certs" {
  description = "Use custom certs?"
  type        = bool
  default     = true
}

variable "cert_dir" {
  description = "Directory containing custom certs"
  type        = string
  default     = "./certs"
}

variable "nodes" {
  type = list(object({
    hostname_override = string
    port              = string
    docker_socket     = string
    role              = list(string)
    ssh_agent_auth    = bool,
    address           = string
    internal_address  = string
    user              = string
  }))
  default = [
    {
      address           = "10.10.10.10"
      internal_address  = "10.10.10.10"
      hostname_override = "controller"
      port              = "22"
      docker_socket     = "/var/run/docker.sock"
      user              = "rke"
      role              = ["controlplane", "etcd"]
      ssh_agent_auth    = false
    },
    {
      address           = "10.10.10.20"
      internal_address  = "10.10.10.20"
      hostname_override = "node1"
      port              = "22"
      docker_socket     = "/var/run/docker.sock"
      user              = "rke"
      role              = ["worker"]
      ssh_agent_auth    = false
    },
    {
      address           = "10.10.10.21"
      internal_address  = "10.10.10.21"
      hostname_override = "node2"
      port              = "22"
      docker_socket     = "/var/run/docker.sock"
      user              = "rke"
      role              = ["worker"]
      ssh_agent_auth    = false
    },
  ]
}

