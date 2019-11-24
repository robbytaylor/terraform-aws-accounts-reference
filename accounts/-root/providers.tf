provider "aws" {
  region = var.region
}

provider "aws" {
  alias  = "test-account"
  region = var.region

  assume_role {
    role_arn = "arn:aws:iam::123456789012:role/AdminUser"
  }
}
