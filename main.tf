provider "aws" {
    region = "us-east-1"  
}

resource "aws_s3_bucket" "bucket"{
  bucket = "prathameshs3bucket7810"

  tags = {
    Name = "My Bucket"
  }
}

resource = "aws_s3_bucket_object" "file" {
  bucket = aws_s3_bucket.bucket.id
  key = "myfile.txt"
  source = "myfile.txt"
}

resource "aws_db_instance" "myrds" {
    allocated_storage   = var.dbstorage
   storage_type        = "gp2"
   identifier          = "rdstf"
   engine              = "mysql"
   engine_version      = "8.0.27"
   instance_class      = "db.t2.micro"
   username            = "admin"
   password            = "Passw0rd!7810"
   publicly_accessible = true
   skip_final_snapshot = true

   tags = {
     Name = "MyRDS"
   }
 }

resource "aws_ecr_repository" "repo" {
  name = "s3-to-rds"

  image_scanning_configuration {
    scan_on_push = true
  }
}

output "ecr_repo_url" {
  value = aws_ecr_repository.example_ecr_repo.repository_url
}
