# create VPC
module "VPC" {
  source           = "../modules/vpc"
  REGION           = var.REGION
  PROJECT_NAME     = var.PROJECT_NAME
  VPC_CIDR         = var.VPC_CIDR
  PUBLIC_SUB1_CIDR    = var.PUBLIC_SUB1_CIDR
  PUBLIC_SUB2_CIDR    = var.PUBLIC_SUB2_CIDR
  PRIVATE_SUB1_CIDR    = var.PRIVATE_SUB1_CIDR
  PRIVATE_SUB2_CIDR    = var.PRIVATE_SUB2_CIDR
}

# create NAT GATEWAY
module "Nat-GW" {
  source           = "../modules/Nat-GW"
  IGW_ID           = module.VPC.IGW_ID
  VPC_ID           = module.VPC.VPC_ID
  PUBLIC_SUB1_ID      = module.VPC.PUBLIC_SUB1_ID
  PUBLIC_SUB2_ID      = module.VPC.PUBLIC_SUB2_ID
  PRIVATE_SUB1_ID      = module.VPC.PRIVATE_SUB1_ID
  PRIVATE_SUB2_ID      = module.VPC.PRIVATE_SUB2_ID
}

# create IAM
module "IAM" {
  source           = "../modules/IAM"
  PROJECT_NAME     = var.PROJECT_NAME
}

# create EKS Cluster
module "EKS" {
  source               = "../modules/EKS"
  PROJECT_NAME         = var.PROJECT_NAME
  EKS_CLUSTER_ROLE_ARN = module.IAM.EKS_CLUSTER_ROLE_ARN
  PUBLIC_SUB1_ID        = module.VPC.PUBLIC_SUB1_ID
  PUBLIC_SUB2_ID        = module.VPC.PUBLIC_SUB2_ID
  PRIVATE_SUB1_ID        = module.VPC.PRIVATE_SUB1_ID
  PRIVATE_SUB2_ID        = module.VPC.PRIVATE_SUB2_ID
}

# create Node Group
module "NodeGroup" {
  source               = "../modules/NodeGroup"
  NODE_GROUP_ARN  = module.IAM.NODE_GROUP_ROLE_ARN
  PRIVATE_SUB1_ID          = module.VPC.PRIVATE_SUB1_ID
  PRIVATE_SUB2_ID          = module.VPC.PRIVATE_SUB2_ID
  EKS_CLUSTER_NAME     = module.EKS.EKS_CLUSTER_NAME
}
