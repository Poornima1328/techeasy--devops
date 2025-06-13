variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "key_name" {
  description = "Key pair name"
  type        = string
}

variable "stage" {
  description = "Environment stage (dev/prod)"
  type        = string
}

