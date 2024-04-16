variable "vpc_cidr_block" {
  type = string
}

variable "subnets" {
  type = map(object({
    cidr_block = string
    AZ = string
    # map_ip = bool
    route_table = string
  }))
}

variable "route_table" {
  type = map(object({
    cidr_block = string
    gateway_id = string
  }))
}