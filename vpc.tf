variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

provider "aws" {
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
  region     = "${var.region}"
}

resource "aws_vpc" "my-vpc-1" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"
  tags {
    Name = "my-vpc-1"
  }
}

resource "aws_subnet" "my-subnet-1" {
  vpc_id     = "${aws_vpc.my-vpc-1.id}"
  cidr_block = "${var.subnet_cidr}"

  tags {
    Name = "my-subnet-1"
  }
}

vars.tf --

variable "region" {
  default = "<your-region>"
}

variable "vpc_cidr" {
  default = "<your-iprange>"
}

variable "subnet_cidr" {
  default = "<your-subnet-range>"
}
~
