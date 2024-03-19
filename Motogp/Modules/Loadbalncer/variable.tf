# Define variables
variable "load_balancer_name" {
  description = "Name for the Application Load Balancer"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the ALB will be created"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs where the ALB will be deployed"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security group IDs for the ALB"
  type        =list(string) 
}