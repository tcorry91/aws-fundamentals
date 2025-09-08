variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  type    = string
  default = "tim-w3d2-console" # your EC2 key pair
}

variable "ingress_cidr" {
  type    = string
  default = "0.0.0.0/0" # tighten to YOUR_IP/32 later
}

variable "role_name" {
  type    = string
  default = "EC2S3Role"
}

variable "tags" {
  type = map(string)
  default = {
    Project = "aws-fundamentals"
    Day     = "week3-day5"
  }
}
