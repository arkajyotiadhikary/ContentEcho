resource "aws_instance" "strapi" {
  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.sg_id]  # Reference the security group by ID

  tags = {
    Name = "StrapiServer"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y nodejs npm git
              npm install -g strapi@latest
              mkdir -p /var/www/strapi
              cd /var/www/strapi
              git clone https://github.com/arkajyotiadhikary/ContentEcho.git
              cd ContentEcho
              git checkout strapi-ec2
              npm install
              npm run develop
              EOF
}
