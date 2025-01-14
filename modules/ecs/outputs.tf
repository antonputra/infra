output "task_execution_role_arn" {
  value = aws_iam_role.execution.arn
}

output "ecs_name" {
  value = aws_ecs_cluster.this.name
}

output "id" {
  value = aws_ecs_cluster.this.id
}

output "sg_id" {
  value = aws_security_group.this.id
}

output "aws_ecs_capacity_provider_name" {
  value = aws_ecs_capacity_provider.this.name
}
