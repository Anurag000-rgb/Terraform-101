provider "aws" {
  region = "us-east-1"
  # export AWS_SECRET_ACCESS_KEY=ZvQPIMx4DiAhp5vkbQC1tCeqKcdKsCRnK94v7fTy
  # export AWS_ACCESS_KEY_ID=AKIA2HCGCDGSKIUHUFUC  
}

variable "all_cidr_block" {
  description = "vpc and subnets cidr block"
  type = list(object({
    cidr_block = string
    name       = string
  }))
}


resource "aws_vpc" "dev-vpc" {
  cidr_block = var.all_cidr_block[0].cidr_block
  tags = {
    Name = var.all_cidr_block[0].name
  }
}

resource "aws_subnet" "dev-subnet1" {
  vpc_id            = aws_vpc.dev-vpc.id
  cidr_block        = var.all_cidr_block[1].cidr_block
  availability_zone = "us-east-1a"
  tags = {
    Name = var.all_cidr_block[1].name
  }
}

data "aws_vpc" "existing-vpc" {
  default = "true"
}

resource "aws_subnet" "dev-subnet2" {
  vpc_id            = data.aws_vpc.existing-vpc.id
  cidr_block        = var.all_cidr_block[2].cidr_block
  availability_zone = "us-east-1a"
  tags = {
    Name = var.all_cidr_block[2].name
  }

}
