# Membuat S3 Bucket untuk menyimpan file state Terraform
resource "aws_s3_bucket" "terraform_state" {
  bucket = "wp-terraform-state-staging"

  tags = {
    Name = "Terraform State Bucket - Staging"
  }
}

# Membuat DynamoDB Table untuk penguncian state
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "tfremotestate-ec2"
  hash_key     = "LockID"
  read_capacity = 20
  write_capacity = 20
  billing_mode   = "PROVISIONED"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Terraform Lock Table - Staging"
  }
}