
variable "AWS_ACCESS_KEY" {} #variables have to be specified in terraform.tfvars ot vars.tf file 
variable "AWS_SECRET_KEY" {} #here secret and access key are varaibles.

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
  iam_instance_profile = "${aws_iam_instance_profile.ec2-role.name}" 
  # instance profile is  used while ec2 with ec2role and giving permissions via s3 .here s3.tf and iam.tf andaws.tf are used. 
   tags {
      Name = "Test-AMI"
       }


}
