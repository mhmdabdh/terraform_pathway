#FIRST - Add you provider, AWS in this case
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.14.0"
    }
  }
}

#SECOND - configure your provider , profile and region in this case
provider "aws" {
  #In provider, the stuff inside this section only will keep changing
  # Configuration options
  profile = "default"
  region = "us-east-1"
}

#THIRD - create your EC2 (i.e., RESOURCE)
#your .aws/credentials file must be in working condition
#pick the AMI from your AWS GUI
resource "aws_instance" "abie_app_server" {
  ami = "ami-051f7e7f6c2f40dc1"
  instance_type = "t2.nano"
#add your resource tags
  tags = {
    Name = "Abie App Server"
  }
} 