output "my_load_balancer_dns_name_public" {
  value = aws_lb.load_balancer["publicLb"].dns_name
}

output "my_load_balancer_dns_name_private" {
    value = aws_lb.load_balancer["privateLb"].dns_name

}

output "target_group" {
  value = aws_lb_target_group.target_group
}

