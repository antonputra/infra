variable "env" {
  type        = string
  description = "Environment name."
}

variable "vpc_id" {
  type        = string
  description = "Amazon Virtual Private Cloud Id."
}

variable "app_sg_id" {
  type        = string
  description = "SG of the app running in ECS cluster."
}

variable "az" {
  type        = string
  description = "Availability zone in AWS."
}

variable "os_disk_size" {
  type        = number
  default     = 20
  description = "Data disk for the postgres."
}

variable "data_disk_size" {
  type        = number
  description = "Data disk for the postgres."
}

variable "ebs_type" {
  type        = string
  description = "The type of EBS volume."
}

variable "ami" {
  type        = string
  description = "AMI for the postgres."
}

variable "machine_type" {
  type        = string
  description = "EC2 type for the postgres."
}

variable "subnet_id" {
  type        = string
  description = "Subnet Id for the postgres."
}

variable "aws_route53_zone_name" {
  type        = string
  description = "Route53 zone name."
}

variable "route53_zone_id" {
  type        = string
  description = "Route53 zone name."
}
