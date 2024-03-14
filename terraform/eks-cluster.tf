module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0"
  cluster_name    = "eks-cluster"
  cluster_version = "1.25"
  subnets         = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  eks_managed_node_group_defaults = {
    instance_type = "t3.micro"
  }

  worker_groups = [
    {
      instance_type = "t3.micro"
      asg_max_size  = 1
    }
  ]
  
}
