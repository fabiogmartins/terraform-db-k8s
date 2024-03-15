module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0"
  cluster_name    = "eks-cluster"
  cluster_version = "1.26"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  worker_groups = [
    {
      instance_type = "t3.micro"
      asg_max_size  = 1
      disk_size     = 20
    }
  ]

  node_groups = {
    ng1 = {
      desired_capacity = 1
      max_capacity     = 1
      min_capacity     = 1
      instance_types   = ["t3.micro"]
      disk_size        = 20
    }
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}