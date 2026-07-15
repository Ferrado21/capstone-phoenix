terraform {
  backend "s3" {
    bucket         = "ayodele-phoenix-capstone-state"
    key            = "phoenix/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
