terraform {
  backend "s3" {
    bucket = "r00tsh-terraform-states"
    key    = "junto-teste/ec2/terraform.tfstate"
    region = "us-east-2"
  }
}
