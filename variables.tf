# VPC Variables 

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Block"
}

variable "instance_tenancy" {
  type        = string
  description = "VPC Instance Tenancy"
}

variable "vpc_name" {
  type        = string
  description = "VPC Name"
}

variable "env" {
  type        = string
  description = "Environment Name"
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS Support"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS Hostnam"
}


# IGW 
variable "igw_name" {
  type        = string
  description = "Internet Gateway Name"
}

variable "repo_full_name" {
  type        = string
  description = "Repo name"
  default     = "stackcouture/karpenter-demo-eks"
}

variable "cluster-name" {
  type        = string
  description = "Cluster Name"
}