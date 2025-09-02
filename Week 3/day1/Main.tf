terraform {
  required_providers {
    aws    = { source = "hashicorp/aws", version = "~> 5.0" }
    random = { source = "hashicorp/random", version = "~> 3.6" }
  }
}

provider "aws" {
  region = "ap-southeast-2" # uses your default profile from this shell
}

resource "random_id" "suffix" { byte_length = 3 }

locals { bucket_name = "tim-w3d1-${random_id.suffix.hex}" }

resource "aws_s3_bucket" "this" {
  bucket = local.bucket_name
  tags   = { Project = "aws-fundamentals", Day = "week3-day1" }
}

output "bucket_name" { value = aws_s3_bucket.this.bucket }