remote_state {
  backend = "s3"

  config = {
    bucket  = "example-bucket"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    region  = "eu-west-1"
    encrypt = true
    acl     = "bucket-owner-full-control"
  }
}
