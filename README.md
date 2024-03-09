# Infraestrutura AWS com Terraform, EKS e RDS

Este guia abrange a configuração de uma infraestrutura robusta na AWS usando Terraform. Ele inclui a criação de um cluster EKS para hospedar uma aplicação Kubernetes e uma instância RDS para o PostgreSQL. A automação do CI/CD é realizada através do GitHub Actions.

## Pré-requisitos

- Conta AWS
- Terraform (versão mais recente)
- AWS CLI configurado na máquina local
- Git e GitHub para versionamento de código e automação CI/CD

## Configuração Inicial

### 1. AWS IAM User

Crie um usuário IAM na AWS com as permissões necessárias para gerenciar os recursos que o Terraform criará. Anote a `AWS Access Key ID` e `AWS Secret Access Key`.

### 2. GitHub Secrets

No repositório do GitHub:
- Acesse "Settings" > "Secrets" > "Actions".
- Adicione os seguintes secrets:
  - `AWS_ACCESS_KEY_ID` - Sua AWS Access Key ID.
  - `AWS_SECRET_ACCESS_KEY` - Sua AWS Secret Access Key.
  - `AWS_REGION` - A região da AWS (ex. `us-east-1`).
  - `DB_USERNAME` - Nome de usuário para a instância RDS.
  - `DB_PASSWORD` - Senha para a instância RDS.
  - `DATABASE_NAME` - Nome do banco de dados.

## Estrutura do Projeto

Organize seu projeto com a seguinte estrutura:

/
├── .github/
│ └── workflows/
│ └── deploy.yml
├── terraform/
│ ├── eks-cluster.tf
│ ├── rds.tf
│ ├── vpc.tf
│ ├── outputs.tf
│ ├── provider.tf
│ └── variables.tf
└── README.md


## Instruções de Configuração e Implantação

### Terraform

- **provider.tf:** Configura o provedor AWS e especifica a região.
- **variables.tf:** Define as variáveis necessárias para a configuração.
- **vpc.tf:** Define a VPC.
- **eks-cluster.tf:** Configura o cluster EKS.
- **rds.tf:** Define a instância RDS para PostgreSQL.

### GitHub Actions (`.github/workflows/deploy.yml`)

Automatiza a implantação utilizando Terraform no push para o branch `main`.

## Execução

Para aplicar a infraestrutura:

1. **Terraform Init:** Dentro da pasta `terraform`, execute `terraform init`.
2. **Terraform Apply:** Execute `terraform apply` para criar os recursos na AWS.

O GitHub Actions irá automatizar a implantação mediante commits no branch `main`.

## Verificação

Verifique no console da AWS se os recursos foram criados conforme esperado e estão operacionais.

## Segurança

Mantenha todas as informações sensíveis como secrets e nunca as exponha ou inclua diretamente em seus arquivos de configuração ou código.


