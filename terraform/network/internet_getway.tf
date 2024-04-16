resource "aws_internet_gateway" "getway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "getway"
  }

}
