variable "iam_policy_name" {
  type    = string
  default = "jenkins_permissions_policy"
}

variable "role_name" {
  type    = string
  default = "jenkins-role"
}

variable "instance_profile_name" {
  type    = string
  default = "jenkins-ec2-instance-profile"
}