resource "aws_autoscaling_group" "this" {
  name = "${var.env}-${var.name}-ecs"

  vpc_zone_identifier = var.subnets

  min_size = var.min_size
  max_size = var.max_size

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}
