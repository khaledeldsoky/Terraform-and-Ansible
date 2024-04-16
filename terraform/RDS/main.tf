resource "aws_db_instance" "db" {
  for_each               = var.aws_db
  engine                 = each.value.engine
  engine_version         = each.value.engine_version
  db_name                = each.value.db_name
  identifier             = each.value.identifier
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  instance_class         = each.value.instance_class
  allocated_storage      = each.value.allocated_storage
  username               = each.value.username
  password               = each.value.password
  vpc_security_group_ids = [each.value.vpc_security_group_ids]
  skip_final_snapshot    = true
  multi_az               = true
  publicly_accessible    = true

  tags = {
    Name = each.key
  }

}


resource "aws_db_subnet_group" "db_subnet" {
  name       = "db_subnet_group"
  subnet_ids = var.db_subnet_ids
}
