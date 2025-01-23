variable "env" {
  type        = string
  description = "Environment name."
}

variable "name" {
  type        = string
  description = "The name of the application."
}

variable "ecs_name" {
  type        = string
  description = "The name of the ECS cluster."
}

variable "task_execution_role_arn" {
  type        = string
  description = "IAM role arn."
}

variable "app_repo" {
  type        = string
  description = "Application ECR repo."
}

variable "app_version" {
  type        = string
  description = "Application version."
}

variable "region" {
  type        = string
  description = "AWS region to provision infrastructure."
}

variable "app_port" {
  type        = number
  description = "The application port."
}

variable "app_cpu" {
  type        = number
  description = "Application CPU"
}

variable "app_memory" {
  type        = number
  description = "Application Memory"
}

variable "ecs_id" {
  type        = string
  description = "Id of the ECS cluster."
}

variable "ecs_sg_id" {
  type        = string
  description = "SG Id of the ECS cluster."
}

variable "subnets" {
  type        = list(string)
  description = "The subnet IDs for the ECS cluster."
}

variable "aws_ecs_capacity_provider_name" {
  type        = string
  description = "ESC capacity provider name"
}

variable "task_envs" {
  type        = list(any)
  description = "ENVs for the task."
}

variable "replicas" {
  type        = number
  description = "Number of replicas to run."
}
