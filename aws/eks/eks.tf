provider "aws" {
  region = local.region
}

data "aws_caller_identity" "current" {}

################################################################################
# EKS Module
################################################################################

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"

  cluster_name                   = local.eks_cluster_name
  cluster_version                = local.cluster_version
  vpc_id                         = local.vpc_id
  control_plane_subnet_ids       = local.control_plane_subnet_ids
  subnet_ids                     = local.subnet_ids
  cluster_endpoint_public_access = local.cluster_endpoint_public_access
  cluster_encryption_config      = local.cluster_encryption_config
  cluster_enabled_log_types      = local.cluster_enabled_log_types
  create_kms_key                 = local.create_kms_key
  aws_auth_roles                 = local.aws_auth_roles
  iam_role_additional_policies   = local.iam_role_additional_policies
  outpost_config                 = {}

  tags = merge(
    local.tags,
    local.cluster_tags
  )

  # Extend cluster security group rules
  cluster_security_group_additional_rules = {
    ingress_nodes_ephemeral_ports_tcp = {
      description                = "Nodes on ephemeral ports"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "ingress"
      source_node_security_group = true
    }
  }

  # Extend node-to-node security group rules
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
  }

  # aws-auth configmap
  create_aws_auth_configmap = false
  manage_aws_auth_configmap = true
}

################################################################################
# Sub-Module Usage on Existing/Separate Cluster
################################################################################

module "eks_managed_node_group" {
  source  = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  version = "19.21.0"

  create          = local.create_managed_node_group
  name            = local.eks_cluster_name
  cluster_name    = module.eks.cluster_name
  cluster_version = module.eks.cluster_version

  subnet_ids                        = local.subnet_ids
  cluster_primary_security_group_id = module.eks.cluster_primary_security_group_id
  vpc_security_group_ids = [
    module.eks.cluster_security_group_id,
  ]

  # EC2
  ami_type              = local.ami_type
  platform              = local.platform
  block_device_mappings = local.block_device_mappings

  desired_size = local.desired_size
  max_size     = local.max_size
  min_size     = local.min_size

  # k8s labels 
  labels = local.labels

  tags = merge(local.tags, { Separate = "eks-managed-node-group" })
}

resource "aws_iam_role_policy_attachment" "node-AmazonEC2RoleforSSM" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  role       = module.eks_managed_node_group.iam_role_name
}

module "self_managed_node_group" {
  source  = "terraform-aws-modules/eks/aws//modules/self-managed-node-group"
  version = "19.21.0"

  create              = local.create_self_managed_node_group
  name                = "separate-self-mng"
  cluster_name        = module.eks.cluster_name
  cluster_version     = module.eks.cluster_version
  cluster_endpoint    = module.eks.cluster_endpoint
  cluster_auth_base64 = module.eks.cluster_certificate_authority_data

  instance_type = local.instance_types

  subnet_ids = local.subnet_ids
  vpc_security_group_ids = [
    module.eks.cluster_primary_security_group_id,
    module.eks.cluster_security_group_id,
  ]

  tags = merge(local.tags, { Separate = "self-managed-node-group" })
}

module "fargate_profile" {
  source  = "terraform-aws-modules/eks/aws//modules//fargate-profile"
  version = "19.21.0"

  create       = local.create_fargate_profile
  name         = "separate-fargate-profile"
  cluster_name = module.eks.cluster_name

  subnet_ids = local.subnet_ids
  selectors = [{
    namespace = "kube-system"
  }]

  tags = merge(local.tags, { Separate = "fargate-profile" })
}

#
# https://github.com/aws-ia/terraform-aws-eks-blueprints-addons/blob/main/tests/complete/main.tf
#
module "eks_blueprints_addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "~> 1.12"

  cluster_name      = module.eks.cluster_name
  cluster_endpoint  = module.eks.cluster_endpoint
  cluster_version   = module.eks.cluster_version
  oidc_provider_arn = module.eks.oidc_provider_arn

  eks_addons = local.eks_addons

  enable_metrics_server = local.enable_metrics_server
}