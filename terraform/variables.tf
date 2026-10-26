variable "aws_region" {
  description = "AWS region for the hackathon"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project resource name prefix"
  type        = string
  default     = "cloudshield"
}