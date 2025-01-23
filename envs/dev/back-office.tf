module "back-office" {
  source = "../../modules/app"

  name         = "back-office"
  app_version  = "v0.1.5"
  app_repo     = "424432388155.dkr.ecr.us-east-2.amazonaws.com/back-office"
  app_port     = 8080
  app_cpu      = 1024
  app_memory   = 512
  replicas     = 10
  namespace_id = aws_service_discovery_private_dns_namespace.ecs.id
  health_check = "echo healthcheck" # TODO: add valid health check

  # TODO: Add all envs
  task_envs = [
    {
      name  = "DATABASE_URL",
      value = "postgresql://temporal:temporal@postgres.dev.exotic.pvt:5432/market_data?connection_limit=50"
    },
    {
      name  = "TEMPORAL_ADDRESS", # TODO: remove if not used
      value = "temporal.dev.exotic.ecs:7233"
    },
    {
      name  = "TEMPORAL_CONNECTION_ADDRESS"
      value = "temporal.dev.exotic.ecs:7233"
    },
    {
      name  = "BINANCE_SPOT_PRICE_API_URL"
      value = "https://api.binance.com/api/v3/ticker/price"
    },
    {
      name  = "BINANCE_FUTURE_PRICE_API_URL"
      value = "https://dapi.binance.com/dapi/v1/exchangeInfo"
    },
    {
      name  = "BINANCE_CANDLESTICK_API_URL"
      value = "https://api.binance.com/api/v3/klines"
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
