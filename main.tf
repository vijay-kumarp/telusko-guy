terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.63.0"
    }

    random = {
      source = "hashicorp/random"
      version = "3.6.2"
    }
  }
}


provider "aws" {
  region = "ap-southeast-2"

}

resource "random_id" "rand_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "TestBucket" {
  bucket = "testingbucket-${random_id.rand_id.hex}"
}

resource "aws_s3_object" "Testfile" {
  bucket = aws_s3_bucket.TestBucket.bucket
  source = "./testfile.txt"
  key = "newfile.txt"
}

output "rand_id" {
  value = random_id.rand_id.hex
  
}