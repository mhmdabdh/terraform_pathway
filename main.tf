#FIRST - Add you provider, AWS in this case
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.14.0"
    }
  }
}

#SECOND - configure your provider , profile and region in this case
provider "aws" {
  #In provider, the stuff inside this section only will keep changing
  # Configuration options
  profile = "default"
  region  = "us-east-1"
}

#THIRD - create your EC2 (i.e., RESOURCE)
#your .aws/credentials file must be in working condition
#pick the AMI from your AWS GUI
resource "aws_instance" "abie_app_server" {
  ami           = "ami-051f7e7f6c2f40dc1"
  instance_type = "t2.micro"
  #add your resource tags
  tags = {
    Name = "Abie App Server" #This will be the tag as well as the name in Front End
  }
}

#FOURTH - How to declare a variable
variable "abie_ec2_instancetype" {
  type    = string
  default = "t2.micro" #Adding this value to avoid getting CLI promt on every \n
  # \n TF plan or apply. IF you want to test variable prompt, uncomment this "default" string value.
}

#FIFTH - How to consume a variable (instance_type) and create an EC2
resource "aws_instance" "abie_app_server2" {
  ami           = "ami-051f7e7f6c2f40dc1"
  instance_type = var.abie_ec2_instancetype
  tags = {
    Name = "abie_app_server2"
  }

}

#SIXTH - How to declare locals
locals {
  another_instance_type = "t2.micro" #making this from nano to micro to avoid charges. Micro is free, Nano is charged
}

#SEVENTH - How to consume locals during EC2 creation
resource "aws_instance" "abie_ec2_withlocals" {
  ami           = "ami-051f7e7f6c2f40dc1"
  instance_type = local.another_instance_type
  tags = {
    Name = "using local parameter"
  }
}


#EIGHTH - how to declare an output for EC2 attribute
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
#In this page you will find 2 keywords, aws_instance & iam_intance_profile
#command construction:  tfec2keyword.abieinstancename.tfiamrolekeyword

output "ec2_instance_iam_role" {
  value = aws_instance.abie_app_server2.iam_instance_profile
}

#since it returned null values, attempting with csomethile else

output "printing_more_values_using_output" {
  value = aws_instance.abie_app_server2.private_ip
  #value1 = aws_instance.abie_app_server2.subnet_id
  #value2 = aws_instance.abie_app_server2
  #value3 =
  #value4 = 
}