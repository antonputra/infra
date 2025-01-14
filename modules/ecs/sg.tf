# This is the security group for the ECS cluster.
resource "aws_security_group" "this" {
  name   = "${var.env}-ecs-node"
  vpc_id = var.vpc_id
}

# Allow inbound traffic from ALB.
resource "aws_vpc_security_group_ingress_rule" "ecs_allow_alb" {
  security_group_id            = aws_security_group.this.id
  referenced_security_group_id = aws_security_group.this.id # TODO: use alb sg
  from_port                    = 8080
  to_port                      = 8080
  ip_protocol                  = "tcp"
}

# Allow all outbound access.
resource "aws_vpc_security_group_egress_rule" "ecs_allow_all" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
