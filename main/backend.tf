terraform {
  backend "s3" {
    bucket = "mrpapp-terrastate"
    key    = "backend/mrpapp.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state"
  }
}