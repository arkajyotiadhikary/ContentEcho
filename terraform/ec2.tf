resource "aws_instance" "medium-cm-ec2" {
  ami = "ami-09040d770ffe2224f"
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = var.subnet_id
  tags = {
    Name = "medium-cm-ec2"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y nodejs npm
              npm install -g strapi@latest
              mkdir -p /var/www/strapi
              cd /var/www/strapi
              npx create-strapi-app my-project --quickstart
              EOF

}


