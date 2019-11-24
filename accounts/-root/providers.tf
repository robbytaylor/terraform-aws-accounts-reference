provider "aws" {
  region = var.region
}

provider "aws" {
  alias  = "staging"
  region = var.region

  assume_role {
    role_arn = "arn:aws:iam::123456789012:role/AdminUser"
  }
}
