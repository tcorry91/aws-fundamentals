variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "tags" {
  type = map(string)
  default = {
    Project = "aws-fundamentals"
    Day     = "week3-day4"
  }
}
