locals {
  accounts = aws_organizations_account.account
}

variable "account_names" {
  type = list(string)
}

variable state_bucket {
  type = string
}

variable email_domain {
  type        = string
  description = "The domain name for email addresses of created accounts"
}

variable email_prefix {
  type        = string
  description = "The prefix for account email addresses. Emails will be in the format <prefix><account name>@<domain>"
}

variable admin_group {
  type    = string
  default = "Admin"
}

variable region {
  type    = string
  default = "eu-west-1"
}

variable role {
  type        = string
  default     = "AdminUser"
  description = "The name of the role which is created in child accounts in order to access them"
}
