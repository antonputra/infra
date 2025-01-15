data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "this" {
  name               = "${var.env}-${var.name}-ecs-app-task"
  assume_role_policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_policy" "this" {
  policy = file("${path.module}/iam/ecs-exec-demo-task-role-policy.json")
  name   = "ecs-exec-demo-task-role-policy"
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = aws_iam_policy.this.arn
  role       = aws_iam_role.this.name
}



# data "aws_iam_policy_document" "this" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["ecs-tasks.amazonaws.com"]
#     }

#     actions = ["sts:AssumeRole"]
#   }
# }

# resource "aws_iam_role" "this" {
#   name               = "${var.ecs_name}-ecs-myapp"
#   assume_role_policy = data.aws_iam_policy_document.this.json
# }

# resource "aws_iam_role_policy_attachment" "this" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
#   role       = aws_iam_role.this.name
# }

