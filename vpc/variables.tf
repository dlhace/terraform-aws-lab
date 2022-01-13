variable "region" {
  type = string
  default = "us-east-1"
}

variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_private_subnets" {
  type = list
}

variable "vpc_public_subnets" {
  type = list
}

variable "tags" {
  type = map
}