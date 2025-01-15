resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.machine_type
  key_name      = "aws-demo"
  monitoring    = false
  subnet_id     = var.subnet_id

  iam_instance_profile = aws_iam_instance_profile.this.name

  root_block_device {
    volume_size = var.os_disk_size
    volume_type = "gp3"
  }

  vpc_security_group_ids = [aws_security_group.this.id]

  tags = {
    Name = "postgres.${var.aws_route53_zone_name}"
  }
}
