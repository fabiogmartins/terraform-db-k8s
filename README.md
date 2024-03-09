# Terraform DB & Kubernetes Deployment

Este repositório contém a infraestrutura como código (IaC) necessária para implantar um ambiente robusto na AWS utilizando Terraform e Kubernetes. Ele é projetado para provisionar um banco de dados RDS para persistência de dados e um cluster EKS para hospedar aplicações, tudo automatizado com workflows de GitHub Actions para CI/CD.

## **Estrutura do Repositório**

- **`terraform/`**: Contém arquivos `.tf` para o provisionamento da infraestrutura na AWS, abrangendo recursos como VPC, subnets, RDS (Relational Database Service) e EKS (Elastic Kubernetes Service).

- **`kubernetes/`**: Armazena arquivos `.yml` para o deploy de aplicações via Kubernetes, incluindo definições de deployments, services, e horizontal pod autoscalers (HPAs).

- **`workflows/`**: Inclui definições de GitHub Actions para automação do processo de CI/CD, facilitando o deploy contínuo da infraestrutura e das aplicações.

## **Pré-requisitos**

Para utilizar este repositório, você precisará ter:

- Uma conta na AWS com as permissões necessárias para criar os recursos especificados nos arquivos Terraform.
- O Terraform instalado na sua máquina local para execução de planos e aplicação de mudanças na infraestrutura.
- O AWS CLI configurado para gerenciar recursos da AWS e interagir com o serviço EKS.
- O `kubectl` configurado para comunicação com o cluster Kubernetes.
- Docker, caso deseje construir e gerenciar imagens de contêiner das suas aplicações.

## **Como Usar**

### Configurando AWS Credentials

Antes de iniciar, configure suas credenciais da AWS. Isso pode ser feito através das variáveis de ambiente `AWS_ACCESS_KEY_ID` e `AWS_SECRET_ACCESS_KEY`, garantindo que o Terraform possa acessar e criar os recursos na AWS.

### Inicialização e Aplicação do Terraform

Navegue até a pasta `terraform/` e inicialize o Terraform:

```bash
cd terraform
terraform init
```

Em seguida, aplique a configuração para provisionar a infraestrutura:
```bash
terraform apply
```

### Configuração do kubectl com EKS
Após o provisionamento do cluster EKS, atualize o arquivo de configuração do kubectl para se conectar ao seu cluster:
```bash
aws eks --region <sua-regiao> update-kubeconfig --name <nome-do-cluster-eks>
```
Substitua <sua-regiao> e <nome-do-cluster-eks> pelos valores apropriados.

### Deploy das Aplicações com Kubernetes
Com o kubectl configurado, você pode agora aplicar as configurações do Kubernetes para deploy das suas aplicações:
```bash
kubectl apply -f kubernetes/
```
### Contribuições
Sua contribuição é bem-vinda! Sinta-se à vontade para forkar o repositório, fazer suas alterações e abrir um pull request.


