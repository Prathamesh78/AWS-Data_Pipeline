provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "prathamesh_bucket"
  acl    = "public-read"

  tags = {
    Name        = "MyBucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "my_bucket_object" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "data/myfile.txt"
  source = "app/data/myfile.txt"  
  acl    = "public-read"
}

resource "aws_db_instance" "my_rds" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  name                 = var.rds_db_name
  username             = var.rds_username
  password             = var.rds_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  tags = {
    Name        = "MyRDSInstance"
    Environment = "Dev"
  }
}

resource "aws_ecr_repository" "my_ecr" {
  name = "my-ecr-repo"

  tags = {
    Name        = "MyECRRepo"
    Environment = "Dev"
  }
}

resource "aws_lambda_function" "lambda" {
  function_name = "my_lambda_function"
  role          = aws_iam_role.lambda_exec.arn
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.my_ecr.repository_url}:latest"

  tags = {
    Name        = "MyLambdaFunction"
    Environment = "Dev"
  }
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

output "s3_bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}

output "rds_endpoint" {
  value = aws_db_instance.my_rds.endpoint
}

output "ecr_repository_url" {
  value = aws_ecr_repository.my_ecr.repository_url
}

