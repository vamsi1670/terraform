
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
  count = "${length(data.aws_availability_zones.azs.names)}"
  availability_zone = "${element(data.aws_availability_zones.azs.names,count.index)}"
        # To make the availability zone dynamic, variable is included.
  vpc_id     = "${aws_vpc.my-vpc-1.id}"
# cidr_block = "${var.subnet_cidr}"
  cidr_block = "${element(var.subnet_cidr,count.index)}"
  tags {
    Name = "my-subnet-${count.index+1}" # increases the subnet count by 1.
  }
}

vars.tf -----------------------------------------------------------------------------------------------------------------------------------
This file also includes the vars.tf , where all the variables are defined.

variable "region" {
  default = "us-east-2"
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "subnet_cidr" {
  type = "list"
  default = ["192.168.1.0/24","192.168.2.0/24","192.168.3.0/24","192.168.4.0/24","192.168.5.0/24","192.168.6.0/24"]
}

# variable "azs" {
#  type = "list"
#  default = ["us-west-2a","us-west-2b","us-west-2c"]
#}

# Declare the data source
data "aws_availability_zones" "azs" {}
