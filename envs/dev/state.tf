# terraform {
#   backend "local" {
#     path = "state/dev/terraform.tfstate"
#   }
# }

# terraform {
#   backend "s3" {
#     profile        = "default"
#     bucket         = "aputra-terraform-state"
#     key            = "dev/terraform.tfstate"
#     region         = "us-east-2"
#     dynamodb_table = "terraform-state"
#     encrypt        = true
#     assume_role = {
#       role_arn = "arn:aws:iam::481665126754:role/terraform-editor"
#     }
#   }
# }
