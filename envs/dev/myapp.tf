module "myapp" {
  source = "../../modules/myapp"

  name        = "myapp"
  app_version = "v17"
  app_repo    = "424432388155.dkr.ecr.us-east-2.amazonaws.com/app"
  app_port    = 8080
  app_cpu     = 1024
  app_memory  = 512

  task_execution_role_arn = module.ecs.task_execution_role_arn
  ecs_name                = module.ecs.ecs_name
  app_iam_policies        = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]

  region                         = var.region
  env                            = var.env
  subnets                        = module.vpc.private_subnets
  aws_ecs_capacity_provider_name = module.ecs.aws_ecs_capacity_provider_name
  ecs_id                         = module.ecs.id
  ecs_sg_id                      = module.ecs.sg_id
}
