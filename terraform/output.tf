# output "bastion_ip" {
# value = module.ec2.public_instance_ips
# }

# output "private_ip" {
# value = module.ec2.private_instance_ips
# }

# output "name" {
#   value = module.lb.my_load_balancer_dns_name_private
# }

# output "ips" {
#   value = module.ec2.type_private_ips
# }

output "name" {
 value = module.ec2.instance_ids
}

# output "rds_address" {
#   value = module.RDS.rds_address
# }

# output "rds_db_name" {
#   value = module.RDS.rds_db_name
  
# }

# output "rds_password" {
#   value = module.RDS.rds_password
#   sensitive = true
# }

# output "rds_username" {
#   value = module.RDS.rds_username
  
# }

# output "route" {
#   value = module.network.route_table_name_public
# }