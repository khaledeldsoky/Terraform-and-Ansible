output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_id" {
  value = { for subnet in aws_subnet.subnets : subnet.tags_all["Name"] => subnet.id }
}


output "vpc_cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

output "nat_id" {
  value = aws_nat_gateway.nat.id
}

output "gatway_id" {
  value = aws_internet_gateway.getway.id
}

# output "route_table_name_public" {
#   depends_on = [ aws_route_table.route_table ]
#   value = aws_route_table.route_table["public_route_table"].tags.Name
# }

# output "route_table_name_private" {
#     depends_on = [ aws_route_table.route_table ]

#   value = aws_route_table.route_table["private_route_table"].tags.Name
# }