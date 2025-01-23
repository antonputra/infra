# Secret name: dev-temporal-database
# Secret key/value: password:temporal

data "aws_secretsmanager_secret_version" "creds" {
  secret_id = "dev-temporal-database"
}

locals {
  db_creds     = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string)
  postgres_url = "postgresql://temporal:${local.db_creds.password}@postgres.dev.exotic.pvt:5432/market_data?connection_limit=50"
}

module "temporal" {
  source = "../../modules/app"

  name         = "temporal"
  app_version  = "1.25.2"
  app_repo     = "temporalio/auto-setup"
  app_port     = 7233
  app_cpu      = 1024
  app_memory   = 512
  replicas     = 1
  health_check = "/usr/local/bin/tctl --address temporal.dev.exotic.ecs:7233 cluster health || exit 1"
  namespace_id = aws_service_discovery_private_dns_namespace.ecs.id
  task_envs = [
    {
      name  = "DB",
      value = "postgres12"
    },
    {
      name  = "DB_PORT",
      value = "5432"
    },
    {
      name  = "POSTGRES_USER",
      value = "temporal"
    },
    {
      name  = "POSTGRES_PWD",
      value = local.db_creds.password
    },
    {
      name  = "POSTGRES_SEEDS",
      value = "postgres.dev.exotic.pvt"
    }
  ]

  task_execution_role_arn = module.ecs.task_execution_role_arn
  ecs_name                = module.ecs.ecs_name

  region                         = var.region
  env                            = var.env
  subnets                        = module.vpc.private_subnets
  aws_ecs_capacity_provider_name = module.ecs.aws_ecs_capacity_provider_name
  ecs_id                         = module.ecs.id
  ecs_sg_id                      = module.ecs.sg_id
}
