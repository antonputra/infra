resource "aws_ecs_task_definition" "this" {
  family             = var.name
  network_mode       = "awsvpc"
  execution_role_arn = var.task_execution_role_arn
  task_role_arn      = aws_iam_role.this.arn
  cpu                = var.app_cpu
  memory             = var.app_memory

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name      = var.name
      image     = "${var.app_repo}:${var.app_version}"
      cpu       = var.app_cpu
      memory    = var.app_memory
      essential = true
      portMappings = [
        {
          containerPort = var.app_port
          hostPort      = var.app_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group  = "${var.env}-${var.name}-${var.name}"
          awslogs-region = var.region
        }
      }
    }
  ])

  depends_on = [aws_cloudwatch_log_group.this]
}
