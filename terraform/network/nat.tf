resource "aws_nat_gateway" "nat" {
 
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.subnets["public_subnet_1"].id

  tags = {
    Name = "nat"
  }

}


resource "aws_eip" "elastic_ip" {
  domain = "vpc"

  tags = {
    Name = "elastic_ip"
  }

}
