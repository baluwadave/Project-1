# Create security group
resource "aws_security_group" "example" {
  name        = var.security_group_name
  description = "Security group created with Terraform"
  vpc_id      = var.vpc_id

  // Ingress rules
  ingress {
    from_port   = var.ingress_rules[0].from_port
    to_port     = var.ingress_rules[0].to_port
    protocol    = var.ingress_rules[0].protocol
    cidr_blocks = var.ingress_rules[0].cidr_blocks
  }

  // Additional ingress rules if needed
   ingress {
     from_port   = var.ingress_rules[1].from_port
     to_port     = var.ingress_rules[1].to_port
     protocol    = var.ingress_rules[1].protocol
    cidr_blocks = var.ingress_rules[1].cidr_blocks
  }



    ingress {
     from_port   = var.ingress_rules[2].from_port
     to_port     = var.ingress_rules[2].to_port
     protocol    = var.ingress_rules[2].protocol
    cidr_blocks = var.ingress_rules[2].cidr_blocks
  }

    ingress {
     from_port   = var.ingress_rules[3].from_port
     to_port     = var.ingress_rules[3].to_port
     protocol    = var.ingress_rules[3].protocol
    cidr_blocks = var.ingress_rules[3].cidr_blocks
  }

    ingress {
     from_port   = var.ingress_rules[4].from_port
     to_port     = var.ingress_rules[4].to_port
     protocol    = var.ingress_rules[4].protocol
    cidr_blocks = var.ingress_rules[4].cidr_blocks
  }
    ingress {
     from_port   = var.ingress_rules[5].from_port
     to_port     = var.ingress_rules[5].to_port
     protocol    = var.ingress_rules[5].protocol
    cidr_blocks = var.ingress_rules[5].cidr_blocks
  }
  // Egress rules if needed
   egress {
    from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }
}


