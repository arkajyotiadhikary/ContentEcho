resource "aws_security_group" "strapi_sg" {
  name        = "strapi_sg"
  description = "Allow SSH and HTTP(s) traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "strapi" {
  ami           = "ami-0c55b159cbfafe1f0"  # Example AMI ID, choose one that matches your region
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  security_groups = [aws_security_group.strapi_sg.name]

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

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }

    inline = [
      "cd /var/www/strapi/ContentEcho",
      "git pull origin strapi-ec2",
      "npm install",
      "npm run develop"
    ]
  }
}
