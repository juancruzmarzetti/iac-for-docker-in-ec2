data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "docker" {
  ami                         = data.aws_ami.amazon-linux-2.id
  instance_type               = "t2.small"
  subnet_id                   = "subnet-080aa089164521ea5"
  key_name                    = "damian2"
  vpc_security_group_ids      = [aws_security_group.docker.id]
  associate_public_ip_address = true

  tags = {
    Name        = "docker-${var.name}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install docker -y",
      "sudo yum install docker conntrack git -y",
      "sudo service docker start",
      "sudo usermod -a -G docker ec2-user",
      "sudo chown ec2-user:docker /var/run/docker.sock",
      "sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose",
      "mkdir compose-files"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./damian2.pem")
      host        = self.public_ip
    }
  }

}