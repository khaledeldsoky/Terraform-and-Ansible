data "aws_ami" "ubuntu22" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


variable "ec2" {
type = map(object({
  ami = string
  instance_type = string
  associate_public_ip = bool
  subnet_id = string
  secuirty_group = string
  aws_key_pair_deployer_key_name_var  = string
}))
}


variable "tls_private_key_var" {
  type = string
}