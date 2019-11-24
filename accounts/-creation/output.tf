output accounts {
  value = zipmap(aws_organizations_account.account.*.name, aws_organizations_account.account.*.id)
}
