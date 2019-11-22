resource aws_iam_group admin {
  count = local.create_iam ? 1 : 0
  name  = var.admin_group_name
}

resource aws_iam_group_policy_attachment admin {
  count      = local.create_iam ? 1 : 0
  group      = aws_iam_group.admin[0].name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource aws_iam_user admins {
  count         = local.create_iam ? length(var.users) : 0
  name          = var.users[count.index]
  force_destroy = false
}

resource aws_iam_group_membership admin {
  count = local.create_iam ? 1 : 0
  name  = "admin-group-membership"

  users = aws_iam_user.admins.*.name
  group = aws_iam_group.admin[0].name
}
