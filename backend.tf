# terraform {
#   backend "s3" {
#     bucket         = "" # bucket name
#     key            = "terraform-demo-fmol/demo.tfstate" # path for the state file
#     region         = "" # region
#     dynamodb_table = "" #dynamodb table name
#     encrypt        = true
#   }
# }