load_balancer_name = "Terraform-load-balancer"
vpc_id = module.vpc.id
subnets = ["module.vpc.Terraform_public_subnet.id","module.vpc.Terraform_private_subnet.id"]
security_groups = ["module.Terraform_sg.id","default"]

