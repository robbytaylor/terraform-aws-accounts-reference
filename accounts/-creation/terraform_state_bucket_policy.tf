data aws_iam_policy_document bucket-policy {
  dynamic statement {
    for_each = local.accounts

    content {
      sid       = "put-state-${local.accounts[statement.key].name}"
      resources = ["arn:aws:s3:::${var.state_bucket}/accounts/${local.accounts[statement.key].name}/*"]
      actions   = ["s3:PutObject"]

      principals {
        type        = "AWS"
        identifiers = ["arn:aws:iam::${local.accounts[statement.key].id}:role/AdminUser"]
      }
    }
  }

  dynamic statement {
    for_each = local.accounts

    content {
      sid       = "list-bucket-${local.accounts[statement.key].name}"
      resources = ["arn:aws:s3:::${var.state_bucket}"]
      actions   = ["s3:ListBucket"]

      principals {
        type        = "AWS"
        identifiers = ["arn:aws:iam::${local.accounts[statement.key].id}:role/AdminUser"]
      }
    }
  }

  depends_on = ["aws_organizations_account.account"]
}

resource "aws_s3_bucket_policy" "teraform-state" {
  bucket = var.state_bucket
  policy = data.aws_iam_policy_document.bucket-policy.json

  depends_on = ["aws_organizations_account.account"]
}
