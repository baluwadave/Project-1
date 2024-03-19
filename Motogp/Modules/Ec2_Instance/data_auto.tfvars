instance_count = 4
image_id = "ami-021a9d8a7dda97aa5"
instance_type = "t2.micro"
sg_id = var.my_sg.sg_id
key_name = "pair"
project = "Terraform_staging"
subnet_id = var.my_public_subnet
environment = "staging"
