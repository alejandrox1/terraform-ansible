provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  count = 1
  # Ubuntu 18.04 in us-east-1.
  ami = "ami-0d2505740b82f7948"
  instance_type = "t2.micro"

  tags {
    Name = "terraform-example"
  }
}
