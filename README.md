# **Terraform DB & Kubernetes Deployment**

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

## **Deploy Automatizado com GitHub Actions**

Este repositório está configurado com GitHub Actions para automatizar o processo de deploy tanto da infraestrutura na AWS quanto das aplicações Kubernetes, sempre que novos códigos são integrados à branch `main`.

### **Como Funciona**

- **Infraestrutura na AWS com Terraform**: Quando alterações são detectadas na pasta `terraform/`, o GitHub Actions executa os passos definidos no workflow para aplicar as mudanças na infraestrutura AWS utilizando Terraform. Isso inclui a criação ou atualização de recursos como VPC, RDS e EKS.

- **Aplicações Kubernetes**: Alterações nas pastas `kubernetes/` disparam o workflow que aplica as configurações Kubernetes no cluster EKS, atualizando deployments, services e outras definições conforme necessário.

### **Workflow do CI/CD**

O arquivo de workflow `.github/workflows/deploy.yml` contém todos os passos necessários para a automação do CI/CD, detalhando as ações de checkout do código, configuração das credenciais AWS, execução dos comandos Terraform e `kubectl` para deploy da infraestrutura e das aplicações.

### **Segurança**

As credenciais da AWS e quaisquer outras informações sensíveis são gerenciadas de forma segura através de Secrets do GitHub, assegurando que as chaves de acesso não sejam expostas e mantendo a segurança do processo de deploy.

### **Executando o Deploy Manualmente**

Embora o processo seja automatizado para execução ao fazer push na branch `main`, você também pode disparar o workflow manualmente através da interface do GitHub Actions, caso seja necessário aplicar as configurações sem uma alteração de código.

### **Monitoramento e Logs**

Após a execução do deploy, é recomendado verificar os logs do GitHub Actions para garantir que todas as etapas foram completadas com sucesso. Além disso, você pode monitorar o estado dos recursos na AWS e no Kubernetes para validar o deploy.

---

Ao seguir estas práticas, o repositório oferece uma solução robusta e automatizada para o deploy contínuo da sua infraestrutura e aplicações, facilitando a gestão e reduzindo a possibilidade de erros humanos.

## **Contribuições**
Sua contribuição é bem-vinda! Sinta-se à vontade para forkar o repositório, fazer suas alterações e abrir um pull request.


