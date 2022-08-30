<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_rke"></a> [rke](#requirement\_rke) | ~> 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | 2.2.3 |
| <a name="provider_rke"></a> [rke](#provider\_rke) | 1.3.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.kube_cluster_yaml](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [rke_cluster.jd](https://registry.terraform.io/providers/rancher/rke/latest/docs/resources/cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cert_dir"></a> [cert\_dir](#input\_cert\_dir) | Directory containing custom certs | `string` | `"./certs"` | no |
| <a name="input_custom_certs"></a> [custom\_certs](#input\_custom\_certs) | Use custom certs? | `bool` | `true` | no |
| <a name="input_ignore_docker_version"></a> [ignore\_docker\_version](#input\_ignore\_docker\_version) | Flag to ignore Docker verion | `bool` | `true` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | RKE Kubernetes version | `string` | `"v1.22.4-rancher1-1"` | no |
| <a name="input_nodes"></a> [nodes](#input\_nodes) | n/a | <pre>list(object({<br>    hostname_override = string<br>    port              = string<br>    docker_socket     = string<br>    role              = list(string)<br>    ssh_agent_auth    = bool,<br>    address           = string<br>    internal_address  = string<br>    user              = string<br>  }))</pre> | <pre>[<br>  {<br>    "address": "10.10.10.60",<br>    "docker_socket": "/var/run/docker.sock",<br>    "hostname_override": "rancho",<br>    "internal_address": "10.10.10.60",<br>    "port": "22",<br>    "role": [<br>      "controlplane",<br>      "worker",<br>      "etcd"<br>    ],<br>    "ssh_agent_auth": false,<br>    "user": "jd"<br>  },<br>  {<br>    "address": "10.10.10.61",<br>    "docker_socket": "/var/run/docker.sock",<br>    "hostname_override": "node1",<br>    "internal_address": "10.10.10.61",<br>    "port": "22",<br>    "role": [<br>      "worker"<br>    ],<br>    "ssh_agent_auth": false,<br>    "user": "jd"<br>  }<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all_nodes"></a> [all\_nodes](#output\_all\_nodes) | Show details for all nodes |
<!-- END_TF_DOCS -->