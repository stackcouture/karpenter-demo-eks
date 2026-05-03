variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "cluster_name" {
  type        = string
  description = "Cluster Name"
}

variable "env" {
  type        = string
  description = "Environment Name"
}

variable "pub_subnet_count" {}
variable "pub_cidr_block" {
  type = list(string)
}
variable "pub_availability_zone" {
  type = list(string)
}
variable "pub_sub_name" {}

variable "private_subnet_count" {}
variable "private_cidr_block" {
  type = list(string)
}
variable "private_availability_zone" {
  type = list(string)
}
variable "private_sub_name" {}