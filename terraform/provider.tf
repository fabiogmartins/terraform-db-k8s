terraform {
  required_version = ">= 0.14.9" # Garante que você está usando uma versão compatível do Terraform

  required_providers {
    aws = {
      source  = "hashicorp/aws" # O provedor da AWS
      version = "~> 3.72.0"       # Especifica a versão do provedor da AWS. Ajuste conforme necessário.
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.11.1" # Certifique-se de usar uma versão compatível
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}