output "RDS" {
  value = aws_db_instance.db
}


output "rds_address" {
  value = aws_db_instance.db["rds_4"].address
}


output "rds_db_name" {
  value = aws_db_instance.db["rds_4"].db_name
}


output "rds_username" {
  value = aws_db_instance.db["rds_4"].username
}


output "rds_password" {
  value = aws_db_instance.db["rds_4"].password
}




