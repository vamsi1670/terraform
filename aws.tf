provider "aws" {
  access_key = "YOUR ACCESS KEY "
  secret_key = "YOUR SECRET KEY "
  region = "us-west-2"
}


resource "aws_key_pair" "deployer-key" {
  key_name   = "deployer-key"
  public_key = "SSH-KEYGEN"
}

resource "aws_instance" "web" {
  ami           = "ami-4e79ed36"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.deployer-key.key_name}"
}
