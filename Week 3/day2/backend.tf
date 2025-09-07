terraform {
  backend "s3" {
    bucket         = "terraform-state-2025-568438991403"
    key            = "Week 3/day2/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "tf-locks"
    encrypt        = true
  }
}
