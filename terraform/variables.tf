variable "aws_region" {
  description = "The aws region to deploy to"
  type = string
  default = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type = string
  default = "t2.micro"
}

variable "key_name" {
  description = "The key name to use for the instance"
  type = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

