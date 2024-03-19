variable "cidr_block_vpc" {
    type = string
    description = "this is my  cidr vlock for my vpc"
}


variable "vpc_name" {
    type = string
    description = "This is My Vpc Name"
}

variable "cidr_block_public_subnet" {
    type = string 
    description = "This is my public subnet cidr block"   
}


variable "public_subnet_name" {
    type = string
    description = "This is my Public subnet name"
}
variable "cidr_block_private_subnet" {
    type = string
    description = "this is my private cidr block"
}


variable "private_subnet_name" {
    type = string
    description = "this is my private subnet name"
}


variable "my_public_rt_name" {
    type = string
    description = "this is my public route table name"
}

variable "my_private_rt_name" {
    type = string
    description = "this is my private route table name"  
}


variable "my_igw_name" {
    type = string
    description = "this is my internet gateway name for this vpc"
}




