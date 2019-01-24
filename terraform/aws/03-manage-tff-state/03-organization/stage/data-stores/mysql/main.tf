terraform {
  required_version = ">= 0.11, < 0.12"

  backend "s3" {}
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "example" {
  name     = "example_database"
  username = "admin"
  password = "${var.db_password}"

  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  skip_final_snapshot = true
}
