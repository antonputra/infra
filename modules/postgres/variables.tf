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



# variable "app_port" {
#   type        = number
#   description = "The application port."
# }

# variable "name" {
#   type        = string
#   description = "The name of the ECS cluster."
# }

# variable "image_id" {
#   type        = string
#   description = "Image Id"
# }

# variable "instance_type" {
#   type        = string
#   description = "Instance type"
# }

# variable "min_size" {
#   type        = number
#   description = "Min size of the cluster."
# }

# variable "max_size" {
#   type        = number
#   description = "Max size of the cluster."
# }

# variable "subnets" {
#   type        = list(string)
#   description = "The subnet IDs for the ECS cluster."
# }
