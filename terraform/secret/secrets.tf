# resource "aws_secretsmanager_secret" "private_key" {
#   name = "private_key"

#   tags = {
#     Name = "private_key"
#   }

# }

# resource "aws_secretsmanager_secret_version" "private_key" {
#   secret_id     = aws_secretsmanager_secret.private_key.id
#   secret_string = tls_private_key.rsa-4096.private_key_openssh
# }
