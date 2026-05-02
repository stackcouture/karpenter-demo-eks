variable "private_subnet_ids" {
  type        = list(string)
  description = "List of Private Subnet IDs"
}

variable "aws_eks_security_group_id" {
  type        = string
  description = "Security Group IDs"
}

variable "is-eks-cluster-enabled" {
  type        = bool
  description = "EKS Cluster Enabled"
}

variable "cluster-name" {
  type        = string
  description = "Cluster name"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}

variable "endpoint-private-access" {
  type        = string
  description = "Cluster EndPoint Private Access"
}

variable "endpoint-public-access" {
  type        = string
  description = "Cluster EndPoint Public Access"
}

variable "env" {
  type        = string
  description = "Environment Name"
}

variable "eks-cluster-role-arn" {
  type        = string
  description = "EKS Cluster Role ARN"
}