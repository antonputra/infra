resource "aws_security_group" "this" {
  name   = "${var.name}-alb"
  vpc_id = var.vpc_id
}

# Allow all inbound traffic on the load balancer listener port
resource "aws_vpc_security_group_ingress_rule" "allow_all_http" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

# Allow all inbound traffic on the load balancer listener port
resource "aws_vpc_security_group_ingress_rule" "allow_all_https" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

# Allow outbound traffic to instances on the instance listener port
resource "aws_vpc_security_group_egress_rule" "allow_app" {
  security_group_id            = aws_security_group.this.id
  referenced_security_group_id = var.ecs_sg_id
  from_port                    = 8080
  to_port                      = 8080
  ip_protocol                  = "tcp"
}
