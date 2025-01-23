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

  service_registries {
    registry_arn   = aws_service_discovery_service.this.arn
    container_name = var.name
  }

  # lifecycle {
  #   ignore_changes = [desired_count]
  # }
}

resource "aws_service_discovery_service" "this" {
  name = var.name

  dns_config {
    namespace_id = var.namespace_id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}
