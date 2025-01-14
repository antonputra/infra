resource "aws_cloudwatch_log_group" "this" {
  name              = "${var.env}-${var.name}-${var.name}"
  retention_in_days = "7"
}
