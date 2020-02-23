# for use with Terraform CLI or as source for Terraform Cloud
# private_key is either a file or the key is written to Terraform Cloud as a sensitive variable
variable "aws_region" {
  description = "target region"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "vpc cidr block"
  default     = "172.16.0.0/16"
}
