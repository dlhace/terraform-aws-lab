region              = "us-east-1"
vpc_name            = "vpc-1"
vpc_cidr            = "10.100.0.0/16"
vpc_private_subnets = ["10.100.1.0/24", "10.100.2.0/24"]
vpc_public_subnets  = ["10.100.11.0/24", "10.100.12.0/24"]
tags                = {
    Owner           = "DLH"
    Billing         = "12345678"
    Environment     = "dev"
    }