resource aws_iam_group admin {
  name = var.admin_group_name
}

resource aws_iam_group_policy_attachment admin {
  group      = aws_iam_group.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource aws_iam_user admins {
  count         = length(var.users)
  name          = var.users[count.index]
  force_destroy = false
}

resource aws_iam_group_membership admin {
  name = "admin-group-membership"

  users = aws_iam_user.admins.*.name
  group = aws_iam_group.admin.name
}
