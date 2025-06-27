variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "ami_id" {
  type        = string
  description = "AMI to use for EC2"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "env_name" {
  type        = string
  description = "Environment name (dev, qa, prod)"
}

variable "key_name" {
  type        = string
  description = "SSH key name"
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "github_token" {
  type        = string
  description = "GitHub token for private config access"
  default     = ""
}
