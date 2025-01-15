resource "aws_ebs_volume" "this" {
  availability_zone = var.az
  size              = var.data_disk_size
  type              = var.ebs_type

  tags = {
    Name = "${var.env}-postgres-data"
  }
}

resource "aws_volume_attachment" "this" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.this.id
  instance_id = aws_instance.this.id
}
