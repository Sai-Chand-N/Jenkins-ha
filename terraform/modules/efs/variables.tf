variable "vpc_id" {
  description = "VPC ID where the EFS and its mount targets will be created"
  type        = string
  default     = ""  # You can provide a default VPC ID here or leave it empty
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EFS mount targets"
  type        = list(string)
  default     = []  # You can provide default subnet IDs here or leave it empty
}

