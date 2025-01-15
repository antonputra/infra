# data "aws_secretsmanager_secret_version" "creds" {
#   secret_id = "postgres-v1"
# }

# locals {
#   db_creds = jsondecode(
#     data.aws_secretsmanager_secret_version.creds.secret_string
#   )
# }

# module "temporal" {
#   source = "../../modules/app"

#   name        = "temporal"
#   app_version = "1.25.2"
#   app_repo    = "temporalio/auto-setup"
#   app_port    = 7233
#   app_cpu     = 1024
#   app_memory  = 512
#   task_envs = [
#     {
#       name  = "DB",
#       value = "postgres12"
#     },
#     {
#       name  = "DB_PORT",
#       value = "5432"
#     },
#     {
#       name  = "POSTGRES_USER",
#       value = "myapp"
#     },
#     {
#       name  = "POSTGRES_PWD",
#       value = local.db_creds.password
#     },
#     {
#       name  = "POSTGRES_SEEDS",
#       value = "postgres.antonputra.pvt"
#     }
#   ]

#   task_execution_role_arn = module.ecs.task_execution_role_arn
#   ecs_name                = module.ecs.ecs_name

#   region                         = var.region
#   env                            = var.env
#   subnets                        = module.vpc.private_subnets
#   aws_ecs_capacity_provider_name = module.ecs.aws_ecs_capacity_provider_name
#   ecs_id                         = module.ecs.id
#   ecs_sg_id                      = module.ecs.sg_id
# }
