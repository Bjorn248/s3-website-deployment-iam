variable "s3-bucket-name" {
  description = "The arn of the S3 bucket you wish to grant permissions to"
  type        = string
}

variable "global-tags" {
  description = "The tags to apply to every resource"
  type        = map(any)
  default     = {}
}
