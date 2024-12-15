variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the EC2 instance will be created"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID where the EC2 instance will be created"
  type        = string
}

variable "your_ip" {
  description = "IP address allowed for SSH access"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket for EC2 access"
  type        = string
} 