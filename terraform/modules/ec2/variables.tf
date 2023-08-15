provider "aws" {
  region = "us-west-2"
}

variable "instance_name" {
  type = string
  default = "live-test-instance"
}

variable "ami_id" {
  type = string
  default = "ami-0ed19c710bbd642a2"
}

variable "instance_type" {
  type = string
  default = "t2.small"
}

variable "key_name" {
  type = string
  default = "slavenode"
}

variable "security_group_ids" {
  type    = list(string)
  default = ["sg-09494f9e8a80fb98b"]
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "subnet_ids" {
  type    = list(string)
  default = ["subnet-0e2ab0de5b7806dc4", "subnet-0d528f3c0ace044bc", "subnet-0737aa97267a4312a"]
}