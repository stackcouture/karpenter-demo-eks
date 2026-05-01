locals {
  tags = {
    "owner"       = "devops"
    "environment" = "dev"
  }
}

resource "aws_kms_key" "terraform-state" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  tags                    = local.tags
}

resource "aws_s3_bucket" "terraform-state" {
  bucket = var.bucket-name
  tags   = local.tags
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.terraform-state.bucket
  versioning_configuration {
    status = "Enabled"
  }

}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform-state" {
  bucket = aws_s3_bucket.terraform-state.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.terraform-state.arn
    }
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.terraform-state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_dynamodb_table" "tf-aws-infra-terraform-locking" {
  name           = var.dynamodb_table
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  tags = local.tags
}
