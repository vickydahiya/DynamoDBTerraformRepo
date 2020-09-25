provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "us-west-2"
  region = "us-west-2"
}

resource "aws_dynamodb_table" "us-east-1" {
  provider = aws.us-east-1

  hash_key         = "assignmentId"
  name             = "assignment"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  read_capacity    = 20
  write_capacity   = 20
  range_key      = "userId"

  attribute {
    name = "assignmentId"
    type = "S"
  }
  
  attribute {
    name = "userId"
    type = "S"
  }
  
  attribute {
    name = "isActive"
    type = "B"
  }
  
    global_secondary_index {
    name               = "UserIdIndex"
    hash_key           = "userId"
    range_key          = "isActive"
    write_capacity     = 20
    read_capacity      = 20
    projection_type    = "INCLUDE"
    non_key_attributes = ["isActive"]
  }
}

resource "aws_dynamodb_table" "us-west-2" {
  provider = aws.us-west-2

  hash_key         = "assignmentId"
  name             = "assignment"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  read_capacity    = 20
  write_capacity   = 20
  range_key      = "userId"

  attribute {
    name = "assignmentId"
    type = "S"
  }
  
  attribute {
    name = "userId"
    type = "S"
  }
  
  attribute {
    name = "isActive"
    type = "B"
  }
  
    global_secondary_index {
    name               = "UserIdIndex"
    hash_key           = "userId"
    range_key          = "isActive"
    write_capacity     = 20
    read_capacity      = 20
    projection_type    = "INCLUDE"
    non_key_attributes = ["isActive"]
  }
}

resource "aws_dynamodb_global_table" "assignment" {
  depends_on = [
    aws_dynamodb_table.us-east-1,
    aws_dynamodb_table.us-west-2,
  ]
  provider = aws.us-east-1

  name = "assignment"

  replica {
    region_name = "us-east-1"
  }

  replica {
    region_name = "us-west-2"
  }
}