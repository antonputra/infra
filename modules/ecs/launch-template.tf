resource "aws_launch_template" "this" {
  name_prefix = "${var.env}-${var.name}-ecs-node"

  image_id      = var.image_id
  instance_type = var.instance_type # 2 CPU

  vpc_security_group_ids = [aws_security_group.this.id]

  iam_instance_profile {
    arn = aws_iam_instance_profile.this.arn
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 30
      volume_type = "gp3"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.env}-${var.name}-ecs"
    }
  }

  user_data = base64encode(templatefile("${path.module}/scripts/ecs.sh", {
    ecs_name = "${var.env}-${var.name}"
  }))
}
