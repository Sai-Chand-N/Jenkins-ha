terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region  = "us-west-2"
  profile = "terraform"
}

module "jenkins_iam" {
  source                = "./modules/iam"
  instance_profile_name = "jenkins_ec2_profile"
  iam_policy_name       = "jenkins_ssm_policy"
  role_name             = "jenkins_ec2_role"
}

module "efs_module" {
  source     = "./modules/efs"
  vpc_id     = "vpc-04eb3561e4a0f5574"
  subnet_ids = ["subnet-0e2ab0de5b7806dc4", "subnet-0d528f3c0ace044bc", "subnet-0737aa97267a4312a"]
}