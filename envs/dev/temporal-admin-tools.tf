module "temporal-admin-tools" {
  source = "../../modules/app"

  name         = "temporal-admin-tools"
  app_version  = "1.25.2-tctl-1.18.1-cli-1.1.1"
  app_repo     = "temporalio/admin-tools"
  app_port     = 7233
  app_cpu      = 1024
  app_memory   = 512
  replicas     = 1
  namespace_id = aws_service_discovery_private_dns_namespace.ecs.id
  health_check = "echo healthcheck" # TODO: add valid health check
  task_envs = [
    {
      name  = "TEMPORAL_CLI_ADDRESS",
      value = "temporal.dev.exotic.ecs:7233"
    },
    {
      name  = "TEMPORAL_ADDRESS",
      value = "temporal.dev.exotic.ecs:7233"
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
