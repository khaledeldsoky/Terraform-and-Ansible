output "private_key" {
  value = tls_private_key.rsa-4096.private_key_openssh
}

output "secuirty_group_id_public" {
  value = aws_security_group.public_secourty_group.id
}

output "secuirty_group_id_private" {
  value = aws_security_group.private_secourty_group.id
}

output "aws_key_pair_deployer_key_name" {
  value = aws_key_pair.deployer.key_name
}
