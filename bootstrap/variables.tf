variable "bucket-name" {
  type        = string
  description = "Bucket Name"
  default     = "eks-dev-terraform-state-bucket"
}

variable "dynamodb_table" {
  type        = string
  description = "Dynamo Table Name"
  default     = "tf-aws-infra-terraform-locking"
}