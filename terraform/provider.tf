terraform {
  required_version = ">= 0.14.9" # Garante que você está usando uma versão compatível do Terraform

  required_providers {
    aws = {
      source  = "hashicorp/aws" # O provedor da AWS
      version = "~> 3.72.0"       # Especifica a versão do provedor da AWS. Ajuste conforme necessário.
    }
  }
}

provider "aws" {
  region = var.aws_region
}
