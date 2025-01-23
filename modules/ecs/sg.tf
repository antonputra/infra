# This is the security group for the ECS cluster.
resource "aws_security_group" "this" {
  name   = "${var.env}-ecs-node"
  vpc_id = var.vpc_id
}

# Allow all outbound access.
resource "aws_vpc_security_group_egress_rule" "ecs_allow_all" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Allow inbound traffic from ALB.
resource "aws_vpc_security_group_ingress_rule" "ecs_allow_alb" {
  for_each = toset(var.alb_sg_ids)

  security_group_id            = aws_security_group.this.id
  referenced_security_group_id = each.key
  from_port                    = 8080
  to_port                      = 8080
  ip_protocol                  = "tcp"
}

# resource "aws_vpc_security_group_ingress_rule" "internal" {
#   security_group_id            = aws_security_group.this.id
#   referenced_security_group_id = aws_security_group.this.id
#   ip_protocol                  = "-1"
# }

# TODO: restrict to only ecs sg or use vpc cidr or private subnet cidr
resource "aws_vpc_security_group_ingress_rule" "ecs_allow_all" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
