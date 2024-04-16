variable "security_group_id" {
  type = string
}

variable "vpc_id" {
  type = string
}



variable "load_balancer" {
  type = map(object({
    lb_subnet_ids = list(string)
    internal = bool
    port     = string
    index    = number

  }))
}

variable "autoscaling_target_group_name" {
  type = string
}

variable "public_target_group_name" {
  type = string
}

variable "aws_autoscaling_group" {
  type = string
}

variable "instanece_ids" {
  type = list(string)
}
