variable "env" {
  type        = string
  description = "Environment name."
}

variable "vpc_id" {
  type        = string
  description = "Amazon Virtual Private Cloud Id."
}

variable "app_port" {
  type        = number
  description = "The application port."
}

variable "name" {
  type        = string
  description = "The name of the ECS cluster."
}

variable "image_id" {
  type        = string
  description = "Image Id"
}

variable "instance_type" {
  type        = string
  description = "Instance type"
}

variable "min_size" {
  type        = number
  description = "Min size of the cluster."
}

variable "max_size" {
  type        = number
  description = "Max size of the cluster."
}

variable "subnets" {
  type        = list(string)
  description = "The subnet IDs for the ECS cluster."
}

variable "alb_sg_ids" {
  type        = list(string)
  description = "SGs of ALBs."
}
