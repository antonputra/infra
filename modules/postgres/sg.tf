resource "aws_security_group" "this" {
  name   = "${var.env}-postgres"
  vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ecs_app" {
  security_group_id            = aws_security_group.this.id
  referenced_security_group_id = var.app_sg_id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
}

# TODO: replca with AWS session manager
# resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
#   security_group_id = aws_security_group.this.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 22
#   to_port           = 22
#   ip_protocol       = "tcp"
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_pg" {
#   security_group_id = aws_security_group.this.id
#   cidr_ipv4         = "10.0.0.0/16"
#   from_port         = 5432
#   to_port           = 5432
#   ip_protocol       = "tcp"
# }

# TODO: remove it, only for testing
# resource "aws_vpc_security_group_ingress_rule" "allow_pg" {
#   security_group_id = aws_security_group.this.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 5432
#   to_port           = 5432
#   ip_protocol       = "tcp"
# }
