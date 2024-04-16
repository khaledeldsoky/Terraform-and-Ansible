data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "subnets" {
  for_each          = var.subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = data.aws_availability_zones.available.names[each.value.AZ]
  # map_public_ip_on_launch = each.value.map_ip
  tags = {
    Name = each.key
  }
}
