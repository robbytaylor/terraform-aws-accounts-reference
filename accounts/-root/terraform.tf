terraform {
  required_version = "~> 0.12"

  backend "s3" {
    bucket         = "example-bucket"
    key            = "accounts/root/terraform.tfstate"
    dynamodb_table = "terraform-state-lock"
    region         = "eu-west-1"
  }
}