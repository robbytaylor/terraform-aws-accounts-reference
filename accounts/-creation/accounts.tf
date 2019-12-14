resource aws_organizations_account account {
  count     = length(local.account_names)
  name      = local.account_names[count.index]
  email     = "${var.email_prefix}${local.account_names[count.index]}@${var.email_domain}"
  role_name = var.role

  lifecycle {
    ignore_changes = [role_name]
  }

  depends_on = ["aws_organizations_organization.org"]
}
