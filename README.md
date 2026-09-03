# db-infra

Infraestrutura do banco de dados gerenciado (Terraform) do projeto **Oficina Mecânica** — Fase 3 do Tech Challenge FIAP.

Provisiona a instância RDS PostgreSQL usada pela aplicação principal (repositório [`api`](https://github.com/FIAP-15SOAT-GabrielHelton/api)).

Este repositório faz parte de um conjunto de 5 (arquitetura completa na [RFC-001](https://github.com/FIAP-15SOAT-GabrielHelton/api/blob/main/docs/fase3/RFC-001-authentication-authorization-serverless.md) do repo `api`):

| Repositório | Responsabilidade |
| :--- | :--- |
| [`k8s-infra`](https://github.com/FIAP-15SOAT-GabrielHelton/k8s-infra) | VPC + EKS + node group |
| `db-infra` (este repo) | RDS PostgreSQL |
| [`api`](https://github.com/FIAP-15SOAT-GabrielHelton/api) | Aplicação Rails + ECR + deploy no cluster |
| [`auth-serverless`](https://github.com/FIAP-15SOAT-GabrielHelton/auth-serverless) | API Gateway + Lambdas de autenticação/RBAC |
| [`deploy-orchestrator`](https://github.com/FIAP-15SOAT-GabrielHelton/deploy-orchestrator) | Dispara e aguarda o deploy dos 4 repos acima, em ordem |

## Dependências

Lê do SSM Parameter Store (publicados pelo `k8s-infra`, que precisa ser implantado primeiro):

| Parâmetro | Uso |
| :--- | :--- |
| `/oficina-mecanica/vpc_id` | VPC onde o RDS e seu Security Group são criados |
| `/oficina-mecanica/subnet_ids` | Subnets do DB Subnet Group |

## Parâmetros publicados

| Parâmetro | Valor | Consumido por |
| :--- | :--- | :--- |
| `/oficina-mecanica/rds_address` | Address do RDS PostgreSQL | `api` |
| `/oficina-mecanica/rds_endpoint` | Endpoint (`host:porta`) do RDS PostgreSQL | `api` |

## Configuração necessária

Secret do repositório: `DB_PASSWORD` (senha do usuário `postgres` do RDS).

## Deploy

Workflow `CD Deploy (RDS PostgreSQL)` (`workflow_dispatch`), recebendo as credenciais temporárias da sessão do AWS Academy.

**Ordem de deploy do projeto**: `k8s-infra` → `db-infra` (este repo) → `api` → `auth-serverless` (ou use o [`deploy-orchestrator`](https://github.com/FIAP-15SOAT-GabrielHelton/deploy-orchestrator)).

## Destroy

Workflow `CD Destroy (RDS PostgreSQL)`. Deve rodar **depois** do destroy do `api` e **antes** do destroy do `k8s-infra`.
