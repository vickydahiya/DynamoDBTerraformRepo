terraform {
  required_version = ">= 0.12"
}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "StudentPractice"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserId"
  range_key      = "PracticeId"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "PracticeId"
    type = "S"
  }

  attribute {
    name = "TopScore"
    type = "N"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  global_secondary_index {
    name               = "PracticeIdIndex"
    hash_key           = "PracticeId"
    range_key          = "TopScore"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["UserId"]
  }
}