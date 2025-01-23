resource "null_resource" "migration_task_run" {
  depends_on = [aws_ecs_task_definition.task_definition]

  provisioner "local-exec" {
    command = <<EOF
    aws ecs run-task \
      --cluster <<cluster_name>> \
      --task-definition <<task_definition_name>> \
      --count 1 --launch-type FARGATE \
      --network-configuration '{     // This is required if you have chosen awsvpc in network config for your task definition. Else, this can be ignored
      "awsvpcConfiguration": {
      "assignPublicIp":"DISABLED",
      "securityGroups": ["<<security_group>>"],
      "subnets": ["<<your subnets>>"]
      }
      }'
EOF
  }
}
