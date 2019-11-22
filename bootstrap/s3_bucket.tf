resource "aws_s3_bucket" "terraform-state-storage-s3" {
  bucket        = var.state_bucket
  acl           = "private"
  force_destroy = false

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes  = ["policy"]
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform-state" {
  bucket = aws_s3_bucket.terraform-state-storage-s3.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
