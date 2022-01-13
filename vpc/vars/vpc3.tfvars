region              = "us-west-2"
vpc_name            = "vpc-3"
vpc_cidr            = "10.200.0.0/16"
vpc_private_subnets = ["10.200.1.0/24", "10.200.2.0/24"]
vpc_public_subnets  = ["10.200.11.0/24", "10.200.12.0/24"]
tags                = {
    Owner           = "DLH"
    Billing         = "12345678"
    Environment     = "dev"
    }