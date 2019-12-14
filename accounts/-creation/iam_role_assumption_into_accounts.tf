data aws_iam_policy_document accounts {
  dynamic statement {
    for_each = local.accounts

    content {
      actions   = ["sts:assumeRole"]
      resources = ["arn:aws:iam::${local.accounts[statement.key].id}:role/${var.role}"]
    }
  }

  depends_on = [aws_organizations_account.account]
}

resource aws_iam_policy accounts {
  name   = "accounts-access"
  policy = data.aws_iam_policy_document.accounts.json

  depends_on = [aws_organizations_account.account]
}

resource aws_iam_group_policy_attachment accounts {
  group      = var.admin_group
  policy_arn = aws_iam_policy.accounts.arn

  depends_on = [aws_organizations_account.account]
}
