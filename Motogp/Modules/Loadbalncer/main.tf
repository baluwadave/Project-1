

# Create ALB
resource "aws_lb" "example" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = var.security_groups

  enable_deletion_protection = false # Set to true to enable deletion protection
  
  # Access logs configuration (Optional)
  // access_logs {
  //   bucket  = "your-s3-bucket"
  //   prefix  = "logs/"
  //   enabled = true
  // }

  # Tags (Optional)
  // tags = {
  //   Name        = "MyLoadBalancer"
  //   Environment = "Production"
  // }
}

# Output
output "load_balancer_dns_name" {
  value = aws_lb.example.dns_name
}
