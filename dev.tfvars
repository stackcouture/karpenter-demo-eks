#VPC 
vpc_cidr             = "10.16.0.0/16"
instance_tenancy     = "default"
vpc_name             = "vpc"
env                  = "dev"
enable_dns_support   = true
enable_dns_hostnames = true


#IGW 
igw_name     = "VPC-IGW"
cluster_name = "eks-cluster"

# Subnets 

pub-subnet-count      = 3
pub-cidr-block        = ["10.16.0.0/20", "10.16.16.0/20", "10.16.32.0/20"]
pub-availability-zone = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
pub-sub-name          = "subnet-public"

pri-subnet-count      = 3
pri-cidr-block        = ["10.16.128.0/20", "10.16.144.0/20", "10.16.160.0/20"]
pri-availability-zone = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
pri-sub-name          = "subnet-private"

public-rt-name  = "public-route-table"
private-rt-name = "private-route-table"

nat_gw_name = "NAT-GW"
eip_name    = "VPC-Elastic-IP"

sg_name        = "eks_cluster_sg"
sg_description = "Security group for EKS cluster"

is_eks_role_enabled           = true
is_eks_nodegroup_role_enabled = true
aws_region                    = "ap-south-1"

is-eks-cluster-enabled  = true
kubernetes_version      = "1.34"
endpoint-private-access = true
endpoint-public-access  = false


instance_types   = ["t3.medium"]
desired_capacity = 1
min_capacity     = 1
max_capacity     = 5


spot_instance_types   = ["c5a.large", "c5a.xlarge", "m5a.large", "m5a.xlarge", "c5.large", "m5.large", "t3a.large", "t3a.xlarge", "t3a.medium"]
desired_capacity_spot = "1"
min_capacity_spot     = "1"
max_capacity_spot     = "10"

addons = [
  {
    name    = "vpc-cni",
    version = "v1.20.0-eksbuild.1"
  },
  {
    name    = "coredns"
    version = "v1.12.2-eksbuild.4"
  },
  {
    name    = "kube-proxy"
    version = "v1.33.0-eksbuild.2"
  },
  {
    name    = "aws-ebs-csi-driver"
    version = "v1.46.0-eksbuild.1"
  }
  # Add more addons as needed
]

cluster_service_ipv4_cidr = "172.20.0.0/16"