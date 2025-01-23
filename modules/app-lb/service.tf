resource "aws_ecs_service" "this" {
  name            = var.name
  cluster         = var.ecs_id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.replicas

  network_configuration {
    subnets         = var.subnets
    security_groups = [var.ecs_sg_id]
  }

  force_new_deployment   = true
  enable_execute_command = true

  placement_constraints {
    type = "distinctInstance"
  }

  triggers = {
    version = var.app_version
  }

  capacity_provider_strategy {
    capacity_provider = var.aws_ecs_capacity_provider_name
    weight            = 100
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = var.name
    container_port   = var.app_port
  }

  #   lifecycle {
  #     ignore_changes = [desired_count]
  #   }
}
