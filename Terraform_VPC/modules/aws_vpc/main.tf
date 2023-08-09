#Resource
resource "aws_vpc" "tcs" {
  cidr_block       = var.vpc_cidr_block
  
  tags = var.tags
}
 
