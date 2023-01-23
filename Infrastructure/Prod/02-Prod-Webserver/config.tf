terraform {
  backend "s3" {
    bucket = "prod-acs730-assigmnent1-safeer"   // Bucket where to SAVE Terraform State
    key    = "prod-webserver/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                        // Region where bucket is created
  }
}