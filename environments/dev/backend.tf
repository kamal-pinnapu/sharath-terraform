terraform {
  backend "s3" {
    bucket         = "abc-zxxx"
    key            = "s3/dev/terraform.tfstate"
    region         = "us-east-2"
    #dynamodb_table = "terraform-locks" (optional)
    encrypt        = true 
  }
}
