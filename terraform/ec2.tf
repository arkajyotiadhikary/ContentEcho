resource "aws_instance" "ar-strapi" {
  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.sg_id]  # Reference the security group by ID

  tags = {
    Name = "ar-strapi"
  }

  user_data = <<-EOF
              #!/bin/bash
              # Update the package index
              sudo apt update -y

              # Install Node.js, npm, and git
              sudo apt install -y nodejs npm git

              # Install PM2 globally
              sudo npm install -g pm2

              # Install Strapi globally
              sudo npm install -g strapi@latest

              # Create directory for Strapi
              mkdir -p /var/www/strapi

              # Navigate to the directory
              cd /var/www/strapi

              # Clone the repository
              git clone https://github.com/arkajyotiadhikary/ContentEcho.git

              # Navigate to the repository
              cd ContentEcho

              # Checkout the specific branch
              git checkout strapi-ec2

              # Install dependencies
              npm install
              EOF
}

resource "null_resource" "provision" {
  depends_on = [aws_instance.ar-strapi]

  connection {
    type        = "ssh"
    host        = aws_instance.ar-strapi.public_ip
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host_key    = "accept-new"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Running remote-exec provisioner'",
      "cd /var/www/strapi/ContentEcho",
      "pm2 start npm --name 'strapi' -- run develop",
      "pm2 save",
      "pm2 startup systemd -u $(whoami) --hp /home/$(whoami)",
      "sudo env PATH=$PATH:/usr/bin pm2 startup systemd -u $(whoami) --hp /home/$(whoami)"
    ]
  }
}
