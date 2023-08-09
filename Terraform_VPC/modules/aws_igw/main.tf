resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpc_id_igw

  tags = var.tags
}

