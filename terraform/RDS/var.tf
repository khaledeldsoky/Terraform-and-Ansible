variable "aws_db" {
  type = map(object({
    engine                 = string
    db_name                = string
    identifier             = string
    allocated_storage      = number
    username               = string
    password               = string
    instance_class         = string
    engine_version         = string
    vpc_security_group_ids = string
  }))
}


variable "db_subnet_ids" {
  type = list(string)
}
