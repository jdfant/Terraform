locals {
  region                         = "us-west-2"
  account                        = "012345678910"
  eks_cluster_name               = "jd-cluster"
  cluster_version                = "1.30" # See https://docs.aws.amazon.com/eks/latest/userguide/kubernetes-versions.html
  cluster_endpoint_public_access = true
  create_kms_key                 = true
  iam_role_use_name_prefix       = true

  # EC2
  instance_types              = "m5.large"            # Example: c6i.large (https://docs.aws.amazon.com/eks/latest/userguide/choosing-instance-type.html)
  ami_type                    = "BOTTLEROCKET_x86_64" # Valid values are 'AL2_x86_64', 'AL2_x86_64_GPU, 'AL2_ARM_64', 'CUSTOM', 'BOTTLEROCKET_ARM_64', 'BOTTLEROCKET_x86_64'.
  ami_release_version         = "1.20.3-5d9ac849"     # Example: BottleRocket Example: 1.20.3-5d9ac849 - Use version number-first 8 chars of commit id (https://github.com/bottlerocket-os/bottlerocket/releases)
  platform                    = "bottlerocket"        # 'bottlerocket' or 'linux'
  http_endpoint               = "enabled"
  http_tokens                 = "optional"
  http_put_response_hop_limit = 2

  # Managed node group scaling_config
  max_size     = 2
  min_size     = 2
  desired_size = 2

  # EC2 Disks
  block_device_mappings = {
    xvda = {
      device_name = "/dev/xvda"
      ebs = {
        volume_size           = 4
        volume_type           = "gp3"
        encrypted             = true
        delete_on_termination = true
      }
    }
    xvdb = {
      device_name = "/dev/xvdb"
      ebs = {
        volume_size           = 512
        volume_type           = "gp3"
        encrypted             = true
        delete_on_termination = true
      }
    }
  }

  tags = {
    Account     = local.account
    ClusterName = local.eks_cluster_name
    Terraformed = "True"
  }

  cluster_tags = {
    ClusterName                                           = local.eks_cluster_name
    Terraformed                                           = "True"
    "kubernetes.io/cluster/${local.eks_cluster_name}"     = "owned"
    "k8s.io/cluster-autoscaler/${local.eks_cluster_name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled"                   = "true"
  }

  # Node Groups
  create_managed_node_group      = true
  create_self_managed_node_group = false
  create_fargate_profile         = false

  enable_metrics_server = true

  eks_addons = {
    # Updating VPC-CNI can only go up or down 1 minor version at a time.
    # Leaving 'most_recent' to true is fine on a fresh install or if you know a version has not been skipped.
    # If you receive version errors, you will need to specify the version.
    # https://docs.aws.amazon.com/eks/latest/userguide/managing-vpc-cni.html
    vpc-cni = {
      addon_name                  = "vpc-cni"
      most_recent                 = true
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
    }
    kube-proxy = {
      addon_name                  = "kube-proxy"
      most_recent                 = true
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
    }
    coredns = {
      addon_name  = "coredns"
      most_recent = true
      configuration_values = jsonencode({
        computeType = "ec2"
      })
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
    }
    aws-ebs-csi-driver = {
      addon_name                  = "aws-ebs-csi-driver"
      service_account_role_arn    = module.eks.cluster_iam_role_arn
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
    }
  }

  aws_auth_roles = [
    {
      rolearn  = module.eks_managed_node_group.iam_role_arn
      username = "system:node:{{EC2PrivateDNSName}}"
      groups = [
        "system:bootstrappers",
        "system:nodes",
      ]
    }
  ]

  cluster_encryption_config = {
    resources = ["secrets"]
  }

  key_owners = [join("/", [split("/", data.aws_caller_identity.current.arn)[0], split("/", data.aws_caller_identity.current.arn)[1]])]

  iam_role_additional_policies = {
    AmazonSSMManagedInstanceCore       = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    AmazonEKSWorkerNodePolicy          = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    AmazonEKSServicePolicy             = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy",
    AmazonEBSCSIDriverPolicy           = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy",
    AmazonEC2RoleforSSM                = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  }

  labels = {
    lifecycle           = "Ec2OnDemand",
    "strict-scheduling" = "ondemand",
    owner               = local.account
  }

  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids = flatten(slice(data.terraform_remote_state.vpc.outputs.private_subnets))

  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler",
  ]
}