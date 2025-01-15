resource "aws_service_discovery_http_namespace" "this" {
  name = "${var.env}-${var.name}"
}

# resource "aws_service_discovery_private_dns_namespace" "this" {
#   name = "${var.env}-${var.name}.pvt"
#   vpc  = var.vpc_id
# }
