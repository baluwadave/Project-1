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




module "my_vpc_module" {
  source = "./Modules/Vpc"
  project = var.project
  vpc_cidr = var.vpc_cidr
  enviorment = var.enviorment
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_cidr = var.public_subnet_cidr
}


module "My_security_group" {
  source = "./Modules/sg-Terraform"
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


module "My_load_Balancer" {
  source = "./Modules/Loadbalncer"
  load_balancer_name = "Terraform-load-balancer"
  vpc_id = module.vpc.id
  subnets = ["module.vpc.Terraform_public_subnet.id","module.vpc.Terraform_private_subnet.id"]
  security_groups = ["module.Terraform_sg.id","default"]
}

module "My_instances" {
  source = "./Modules/Ec2_insatnce"
  instance_cocount = var.instance_count
  ami = var.image_id
  instance_type = var.instance_type
  key_name = var.key_name
  project = var.project
  enviorment = var.enviorment
  subnet_id = module.my_vpc_module.public_subnet_id  # it will create from vpc when vpc will create & this id will only bounded with vpc directory if we want sg_id from vpc so we need to use the "output_block"
  sg_ids = [aws_security_group.my_sg.id]    
}



module "my_bucket" {
  source = "./Modules/s3"
}