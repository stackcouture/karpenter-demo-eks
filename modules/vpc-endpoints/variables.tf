variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "private_route_table_id" {
  type        = string
  description = "Private Route Table ID"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "env" {
  type        = string
  description = "Environment Name"
}

variable "s3_vpc_enpoint_name" {
  type        = string
  description = "S3 VPC Endpoint Name"
}