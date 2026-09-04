# Lê a VPC e as subnets publicadas pelo repositório k8s-infra via SSM
# Parameter Store, para não depender de acesso ao tfstate daquele repositório.

data "aws_ssm_parameter" "vpc_id" {
  name = "/oficina-mecanica/vpc_id"
}

data "aws_ssm_parameter" "subnet_ids" {
  name = "/oficina-mecanica/subnet_ids"
}

locals {
  vpc_id     = data.aws_ssm_parameter.vpc_id.value
  subnet_ids = split(",", data.aws_ssm_parameter.subnet_ids.value)
}

data "aws_vpc" "main" {
  id = local.vpc_id
}
