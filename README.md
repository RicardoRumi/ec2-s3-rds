# Infraestrutura AWS com Terraform

Este projeto contém a configuração Terraform para criar uma infraestrutura básica na AWS, incluindo **VPC**, **RDS**, **EC2** e **S3**.

## Arquitetura

A infraestrutura inclui:

### VPC
- 2 sub-redes públicas
- 2 sub-redes privadas
- Internet Gateway
- Tabelas de rota configuradas

### EC2
- 1 instância em sub-rede pública
- Security Group configurado para SSH e HTTP/HTTPS
- IAM Role com permissões para S3

### S3
- Bucket com versionamento habilitado
- Acesso público bloqueado
- Políticas de acesso configuradas

### RDS MySQL
- Instância MySQL em sub-rede privada
- Security Group configurado para acesso apenas da instância EC2
- Backup automático configurado
- Multi-AZ opcional para alta disponibilidade

## Pré-requisitos

- Terraform (versão >= 0.12)
- Conta AWS com credenciais de acesso
- AWS CLI (opcional)

## Estrutura do Projeto

```plaintext
.
├── main.tf                 # Configuração principal
├── variables.tf            # Definição de variáveis
├── outputs.tf              # Outputs do projeto
├── terraform.tfvars.example  # Exemplo de variáveis
└── modules/                # Módulos do projeto
    ├── vpc/                # Módulo VPC
    ├── ec2/                # Módulo EC2
    └── rds/                # Módulo RDS
    └── s3/                 # Módulo S3
```

## Configurando Perfil no AWS CLI

Antes de executar os comandos do Terraform, certifique-se de que suas credenciais AWS estão configuradas no AWS CLI. Isso é importante para que o Terraform consiga autenticar e interagir com os recursos AWS.

### Passo a Passo

1. Abra um terminal e execute o seguinte comando:
   ```bash
   aws configure
   ```
2. Insira os detalhes solicitados:
   - **AWS Access Key ID**: Sua chave de acesso.
   - **AWS Secret Access Key**: Sua chave secreta.
   - **Default region name**: A região onde você deseja criar os recursos (por exemplo, `us-east-1`).
   - **Default output format**: Formato de saída dos comandos AWS CLI. Pode ser `json`, `text` ou `table`. Use `json` para maior compatibilidade.

## Configuração Inicial

1. Clone o repositório:
   ```bash
   git clone <repository-url>
   cd <repository-name>
   ```

2. Copie o arquivo de exemplo de variáveis:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

3. Edite o arquivo `terraform.tfvars` com suas configurações:
   ```hcl
   aws_region = "us-east-1"
   environment = "dev"
   vpc_cidr = "10.0.0.0/16"
   public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
   private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
   your_ip = "SEU_IP/32"
   bucket_name = "seu-bucket-unico"
   database_name       = "myappdb"
   database_username   = "admin"
   database_password   = "your-secure-password-here"
   rds_instance_class = "db.t3.micro"
   ```

## Comandos de Execução

1. Inicialize o Terraform e baixe os providers necessários:
   ```bash
   terraform init
   ```

2. Formate e valide os arquivos de configuração:
   ```bash
   terraform fmt
   terraform validate
   ```

3. Crie um plano de execução e salve em um arquivo:
   ```bash
   terraform plan -out=tfplan
   ```

4. Revise o plano gerado e aplique as mudanças:
   ```bash
   terraform show tfplan
   terraform apply tfplan
   ```

5. Para destruir a infraestrutura, crie e aplique um plano de destruição:
   ```bash
   terraform plan -destroy -out=tfplan-destroy
   terraform apply tfplan-destroy
   ```

## Comandos Úteis Adicionais

- Visualizar o estado atual:
  ```bash
  terraform show
  ```

- Listar recursos no estado:
  ```bash
  terraform state list
  ```

- Atualizar o estado com mudanças manuais na infraestrutura:
  ```bash
  terraform refresh
  ```

- Importar recursos existentes:
  ```bash
  terraform import aws_instance.example i-1234567890abcdef0
  ```

## Outputs

Após a aplicação bem-sucedida, você pode verificar os outputs com:
```bash
terraform output
```

### Outputs Disponíveis
- `instance_public_ip`: IP público da instância EC2
- `vpc_id`: ID da VPC criada
- `s3_bucket_name`: Nome do bucket S3

## Segurança

- O arquivo `terraform.tfvars` contém informações sensíveis e está incluído no `.gitignore`
- O acesso SSH à instância EC2 é restrito ao IP configurado
- O bucket S3 tem acesso público bloqueado
- A instância EC2 usa uma IAM Role com permissões mínimas necessárias

## Boas Práticas

- Mantenha as credenciais AWS seguras e nunca as commite no repositório
- Use variáveis para valores que podem mudar entre ambientes
- Aplique tags apropriadas aos recursos para melhor organização
- Revise as mudanças antes de aplicar em produção
- Sempre crie e revise um plano antes de aplicar mudanças
- Mantenha o código formatado usando `terraform fmt`
- Valide as configurações com `terraform validate`

## Troubleshooting

Se encontrar erros:
1. Verifique se as credenciais AWS estão corretas
2. Confirme se o nome do bucket S3 é único globalmente
3. Verifique se o IP configurado para acesso SSH está correto
4. Consulte os logs de erro com:
   ```bash
   terraform apply -log-level=DEBUG
   ```

## Contribuição

1. Faça um Fork do projeto
2. Crie uma branch para sua feature:
   ```bash
   git checkout -b feature/AmazingFeature
   ```

3. Commit suas mudanças:
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```

4. Push para a branch:
   ```bash
   git push origin feature/AmazingFeature
   ```

5. Abra um Pull Request

## Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
