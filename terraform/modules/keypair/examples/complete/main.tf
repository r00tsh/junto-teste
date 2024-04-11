module "keypair-ssm" {
  source = "../../"

  key_name = "example"
  tags     = {}
}