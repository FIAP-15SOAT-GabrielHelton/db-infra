# Publica o endpoint do RDS para o repositório `api` consumir no deploy da aplicação.
#
# overwrite = true: o AWS Academy não garante que o state remoto (S3) e os
# recursos reais fiquem sempre sincronizados entre sessões (ex: um destroy
# anterior que não rodou até o fim) — sem overwrite, um PutParameter contra um
# parametro que já existe fora do state falha com ParameterAlreadyExists.

resource "aws_ssm_parameter" "rds_address" {
  name      = "/oficina-mecanica/rds_address"
  type      = "String"
  value     = aws_db_instance.postgres.address
  overwrite = true
}

resource "aws_ssm_parameter" "rds_endpoint" {
  name      = "/oficina-mecanica/rds_endpoint"
  type      = "String"
  value     = aws_db_instance.postgres.endpoint
  overwrite = true
}
