terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.41.0"
    }
  }
}



provider "aws" {
    region = "ap-northeast-3"
    shared_config_files =["/root/.aws/config"]  
    shared_credentials_files = ["/root/.aws/credentials"]
    profile = "balu"
}


terraform {
  backend "s3" {
    bucket = "terraform-staging-environmet-backend"
    key = "Terraform/terraform.tfstate"
    region ="ap-south-1"
    dynamodb_table = "Terraform-server-backend"   
  }
}




module "vpc" {
  source = "./vpc"
  cidr_block_vpc = "172.16.0.0/16"
  cidr_block_private_subnet = "172.16.0.1/26"
  cidr_block_public_subnet = "172.16.0.0/26"
  vpc_name = "My_Terraform_vpc"
  public_subnet_name = "Terraform_public_subnet"
  private_subnet_name = "Terraform_private_subnet"
  my_public_rt_name = "Terraform_public_rt"
  my_private_rt_name = "Terraform_private_rt"
  my_igw_name = "Terraform_igw"
  # project = var.project
  # vpc_cidr = var.vpc_cidr
  # enviorment = var.enviorment
  # private_subnet_cidr = var.private_subnet_cidr
  # public_subnet_cidr = var.public_subnet_cidr
}


module "aws_security_group" {
  source = "./sg-Terraform"
  security_group_name = "Terraform_sg"
  vpc_id = module.vpc.vpc_id
  ingress_rules = [ {
      
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 3000
      to_port     = 3000
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 9100
      to_port     = 9100
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 9090
      to_port     = 9090
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
        {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
        {
      from_port   = 22
      to_port     = 22
      protocol    = "ssh"
      cidr_blocks = ["0.0.0.0/0"]
    }
 ]
}


module "Loadbalncer" {
  source = "./modules/Loadbalncer"
  load_balancer_name = "Terraform-load-balancer"
  vpc_id = module.vpc.id
  subnets = ["module.vpc.Terraform_public_subnet.id","module.vpc.Terraform_private_subnet.id"]
  security_groups = ["module.Terraform_sg.id","default"]
}

module "aws_instance" {
  source = "./modules/Ec2_insatnce"
  instance_cocount = var.instance_count
  ami = var.image_id
  instance_type = var.instance_type
  key_name = var.key_name
  project = var.project
  enviorment = var.enviorment
  subnet_id = module.my_vpc_module.public_subnet_id  # it will create from vpc when vpc will create & this id will only bounded with vpc directory if we want sg_id from vpc so we need to use the "output_block"
  sg_ids = [aws_security_group.my_sg.id]    
}



module "aws_s3_bucket" {
  source = "./modules/s3"
}