module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  env                  = var.env
  instance_tenancy     = var.instance_tenancy
  vpc_name             = var.vpc_name
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
}

module "igw" {
  source       = "./modules/igw"
  vpc_id       = module.vpc.vpc_id
  igw_name     = var.igw_name
  env          = var.env
  cluster_name = var.cluster_name
}

module "subnets" {
  source                = "./modules/subnets"
  vpc_id                = module.vpc.vpc_id
  env                   = var.env
  cluster_name          = var.cluster_name
  pub_sub_name          = var.pub_sub_name
  pub_subnet_count      = var.pub_subnet_count
  pub_cidr_block        = var.pub_cidr_block
  pub_availability_zone = var.pub_availability_zone

  private_sub_name          = var.private_sub_name
  private_subnet_count      = var.private_subnet_count
  private_cidr_block        = var.private_cidr_block
  private_availability_zone = var.private_availability_zone
}

module "route_table" {
  source          = "./modules/rt"
  vpc_id          = module.vpc.vpc_id
  env             = var.env
  public_rt_name  = var.public_rt_name
  private_rt_name = var.private_rt_name
  igw_id          = module.igw.igw_id
  # nat_gateway_id     = module.nat.nat_gateway_id
  public_subnet_ids  = module.subnets.public_subnets
  private_subnet_ids = module.subnets.private_subnets

}

# module "nat" {
#   source            = "./modules/nat"
#   vpc_id            = module.vpc.vpc_id
#   env               = var.env
#   eip_name          = var.eip_name
#   igw_id            = module.igw.igw_id
#   nat_gw_name       = var.nat_gw_name
#   public_subnet_ids = module.subnets.public_subnets
# }

module "sg" {
  source         = "./modules/sg"
  vpc_id         = module.vpc.vpc_id
  env            = var.env
  sg_name        = var.sg_name
  sg_description = var.sg_description
  cluster_name   = var.cluster_name
}

module "iam" {
  source                        = "./modules/iam"
  cluster_name                  = var.cluster_name
  aws_region                    = var.aws_region
  is_eks_nodegroup_role_enabled = var.is_eks_nodegroup_role_enabled
  is_eks_role_enabled           = var.is_eks_role_enabled
}

module "vpc_endpoints" {
  source                 = "./modules/vpc-endpoints"
  aws_region             = var.aws_region
  private_route_table_id = module.route_table.private_rt_id
  vpc_id                 = module.vpc.vpc_id
  s3_vpc_enpoint_name    = var.s3_vpc_enpoint_name
  env                    = var.env
}

# module "eks" {
#   source                    = "./modules/eks"
#   cluster_name              = var.cluster_name
#   is_eks_cluster_enabled    = var.is_eks_cluster_enabled
#   kubernetes_version        = var.kubernetes_version
#   endpoint_private_access   = var.endpoint_private_access
#   endpoint_public_access    = var.endpoint_public_access
#   aws_eks_security_group_id = module.sg.eks_cluster_sg-id
#   eks_cluster_role_arn      = module.iam.eks_cluster_role_arn
#   private_subnet_ids        = module.subnets.private_subnets
#   env                       = var.env
#   desired_capacity          = var.desired_capacity
#   min_capacity              = var.min_capacity
#   max_capacity              = var.max_capacity
#   instance_types            = var.instance_types
#   node_eks_role_arn         = module.iam.eks_nodegroup_role-arn
#   addons                = var.addons
#   cluster_service_ipv4_cidr = var.cluster_service_ipv4_cidr
# }