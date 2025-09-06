variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Existing EC2 key pair name in ap-southeast-2"
  type        = string
}

variable "ami_id" {
  description = "Optional explicit AMI ID (overrides lookup if set)"
  type        = string
  default     = ""
}

variable "ingress_cidr" {
  description = "CIDR allowed to SSH/HTTP (set to YOUR_IP/32 ideally)"
  type        = string
  default     = "0.0.0.0/0"
}
