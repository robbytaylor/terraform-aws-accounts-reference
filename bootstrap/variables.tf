variable state_bucket {
  type = string
}

variable admin_group_name {
  type    = string
  default = "Admin"
}

variable dynamodb_table {
  type    = string
  default = "terraform-state-lock"
}

variable region {
  type    = string
  default = "eu-west-1"
}

variable users {
  type    = list(string)
  default = []
}
