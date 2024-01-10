variable "region" {
  description = "The region where AWS resources will be created"
  type        = string
  default     = "us-west-1"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {
    Terraform   = "true"
    Environment = "demo"
  }
}