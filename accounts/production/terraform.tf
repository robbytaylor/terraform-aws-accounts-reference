terraform {
  required_version = "~> 0.12"

  backend "s3" {
    bucket  = "example-bucket"
    key     = "accounts/production/terraform.tfstate"
    region  = "eu-west-1"
    acl     = "bucket-owner-full-control"
    encrypt = true
  }
}
