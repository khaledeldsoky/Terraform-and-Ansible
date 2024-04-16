data "aws_instances" "type_public"{
  depends_on = [aws_instance.ec2]
  filter {
    name = "tag:type"
    values = ["public"]
  }
}


data "aws_instances" "type_private"{
  depends_on = [aws_instance.ec2]
  filter {
    name = "tag:type"
    values = ["private"]
  }
}

output "type_private_ips" {
  value = data.aws_instances.type_private.private_ips
}

output "instance_ids" {
  value = { for instance in aws_instance.ec2 :  instance.tags_all["Name"] => instance.id }
}


output "ec2" {
  description = "List of EC2 instances created"
  value       = aws_instance.ec2
}



output "public_instance_ips" {
  value = data.aws_instances.type_public.public_ips
}

output "private_instance_ips" {
  value = data.aws_instances.type_private.private_ips
}
