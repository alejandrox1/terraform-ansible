provider "aws" {
  region = "us-east-1"
}

variable "server_port" {
  description = "Port for web server to connect to"
  default     = 8080
}

resource "aws_security_group" "instance" {
  name = "web-server-instance"

  ingress {
    from_port   = "${var.server_port}"
    to_port     = "${var.server_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  # Ubuntu 16.04 has busyboox already installed.
  ami                    = "ami-40d28157"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]

  user_data = <<-EOF
  #!/bin/bash
  echo "Hello, AWS!" > index.html
  nohup busybox httpd -f -p "${var.server_port}" &
  EOF

  tags {
    Name = "web-server"
  }
}

output "public_ip" {
  value = "${aws_instance.example.public_ip}"
}
