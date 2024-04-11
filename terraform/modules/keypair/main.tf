resource "tls_private_key" "default" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "generated" {
  depends_on = [tls_private_key.default]
  key_name   = var.key_name
  public_key = tls_private_key.default.public_key_openssh
}

resource "aws_ssm_parameter" "private_key_openssh" {
  name  = "/keypair/${var.key_name}/private_key_openssh"
  type  = "SecureString"
  value = tls_private_key.default.private_key_openssh
  tags = merge(
    tomap(
      {
        "Terraform" = "true"
      }
    ),
    var.tags
  )
}

resource "aws_ssm_parameter" "public_key_openssh" {
  name  = "/keypair/${var.key_name}/public_key_openssh"
  type  = "String"
  value = tls_private_key.default.public_key_openssh
  tags = merge(
    tomap(
      {
        "Terraform" = "true"
      }
    ),
    var.tags
  )
}
