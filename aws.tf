
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

provider "aws" {
  access_key = "YOUR ACCESS KEY "
  secret_key = "YOUR SECRET KEY "
  region = "us-west-2"
}


resource "aws_key_pair" "deployer-key" {
  key_name   = "deployer-key"
  public_key = "SSH-KEYGEN" # To generate the key copy the resource key-pair from terraform resource and delete the key ,generate the key using 
                              ssh-keygen -f <keyname> and copy the <keyname.pub> in the .tf file.
}

resource "aws_instance" "web" {
  ami           = "your-ami-id"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.deployer-key.key_name}"
}
