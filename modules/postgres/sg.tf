resource "aws_security_group" "this" {
  name   = "${var.env}-postgres"
  vpc_id = var.vpc_id
}

# SSM manager
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
