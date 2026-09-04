# Publica o endpoint do RDS para o repositório `api` consumir no deploy da aplicação.

resource "aws_ssm_parameter" "rds_address" {
  name  = "/oficina-mecanica/rds_address"
  type  = "String"
  value = aws_db_instance.postgres.address
}

resource "aws_ssm_parameter" "rds_endpoint" {
  name  = "/oficina-mecanica/rds_endpoint"
  type  = "String"
  value = aws_db_instance.postgres.endpoint
}
