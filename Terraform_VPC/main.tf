module "vpc_module" {
  source = "./modules/aws_vpc"

  for_each = var.vpc_config

  vpc_cidr_block = each.value.vpc_cidr_block

  tags = each.value.tags
}

module "aws_subnet" {
  
  source = "./modules/aws_subnets"

  for_each = var.subnet_config

  vpc_id = module.vpc_module[each.value.vpc_name].vpc_id

  cidr_block = each.value.cidr_block

  availability_zone = each.value.availability_zone

  tags = each.value.tags

}

module "aws_internetgw" {
  
  source = "./modules/aws_igw"

  for_each = var.igw_config

  vpc_id = module.vpc_module[each.value.vpc_name].vpc_id

  tags = each.value.tags

}

module "natGW" {

  source = "./modules/aws_natGW"

  for_each = var.natGW_config

  elastic_ip_id = module.Elastic_IP[each.value.eip01].elasticIP_id

  subnet_id = module.aws_subnet[each.value.subnet_name].subnet_id

  tags = each.value.tags

}

module "Elastic_IP" {

  source = "./modules/aws_elasticIP"

  for_each = var.elasticIP_config
  
  tags = each.value.tags
}

module "route_table" {

  source = "./modules/aws_route_table"

  for_each = var.rt_config

  vpc_id = module.vpc_module[each.value.vpc_name].vpc_id

  igw_id = each.value.private == 0 ? module.aws_internetgw[each.value.gateway_name].aws_igw_id : module.natGW[each.value.gateway_name].natGW_id
   
  tags = each.value.tags
    
  }

 

module "route_table_association" {
  
  source = "./modules/aws_rt_association"
  
  for_each = var.rt_association_config
  subnet_id = module.aws_subnet[each.value.subnet_name].subnet_id

  route_table_id = module.route_table[each.value.route_table_name].route_table_id

}