
output "vpc_id" {
  value = aws_vpc.hack-vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "storage_bucket_name" {
  value = aws_s3_bucket.project_storage.bucket
}
