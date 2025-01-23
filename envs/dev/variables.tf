variable "terraform_profile" {
  type        = string
  description = "Terraform profile."
}

variable "env" {
  type        = string
  description = "Environment name."
}

variable "region" {
  type        = string
  description = "AWS region to provision infrastructure."
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR range for the AWS virtual private cloud."
}

variable "az1" {
  type        = string
  description = "Availability zone in AWS."
}

variable "az2" {
  type        = string
  description = "Availability zone in AWS."
}

variable "domain" {
  type        = string
  description = "Domain"
}
