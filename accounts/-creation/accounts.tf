resource aws_organizations_account account {
  count     = length(var.account_names)
  name      = var.account_names[count.index]
  email     = "${var.email_prefix}${var.account_names[count.index]}@${var.email_domain}"
  role_name = var.role

  lifecycle {
    ignore_changes = [role_name]
  }

  depends_on = ["aws_organizations_organization.org"]
}
