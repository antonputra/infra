data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "this" {
  name               = "${var.env}-postgres"
  assume_role_policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.env}-postgres"
  role = aws_iam_role.this.name
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.this.name
}
