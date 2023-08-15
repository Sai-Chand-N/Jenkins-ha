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

module "lb-asg" {
  source        = "./modules/lb-asg"
  subnets       = ["subnet-0e2ab0de5b7806dc4", "subnet-0d528f3c0ace044bc", "subnet-0737aa97267a4312a"]
  ami_id        = "ami-0c040fe3f012173f7"
  instance_type = "t2.small"
  key_name      = "jenkins-ha"
  environment   = "dev"
  vpc_id        = "vpc-04eb3561e4a0f5574"
}

module "ec2_instance" {
  source         = "./modules/ec2"
  instance_name  = "jenkins-agent"
  ami_id         = "ami-0ed19c710bbd642a2"
  instance_type  = "t2.small"
  key_name       = "slavenode"
  subnet_ids     = ["subnet-0e2ab0de5b7806dc4", "subnet-0d528f3c0ace044bc", "subnet-0737aa97267a4312a"]
  instance_count = 1
}