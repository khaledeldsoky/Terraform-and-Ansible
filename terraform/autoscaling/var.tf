variable "launch_template" {
  type = map(object({
    instance_ami                   = string
    instance_type                  = string
    vpc_security_group_ids         = string
    aws_key_pair_deployer_key_name = string
    target_group_arns              = string
    subnet_id                      = list(string)
  }))
}
variable "vpc_id" {
  type = string
}

variable "RDS" {
  type = map(object({
    dbname     = string
    dbusername = string
    dbhost     = string
    dbpassword = string
  }))
}
