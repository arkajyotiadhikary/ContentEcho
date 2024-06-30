terraform {
  required_version = ">= 0.14"
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "terraform/state"
    region = var.aws_region
  }
}

module "ec2" {
  source = "."
}
