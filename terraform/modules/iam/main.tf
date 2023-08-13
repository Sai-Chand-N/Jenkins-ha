# Create an IAM policy
resource "aws_iam_policy" "jenkins_ssm_policy" {
  name        = var.iam_policy_name
  path        = "/"
  description = "jenkins permissions policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

# Create an IAM role
resource "aws_iam_role" "jenkins_ec2_role" {
  name = var.role_name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    "Application" = "Jenkins"
  }
}

# Attach the IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "jenkins_policy_attach" {
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = aws_iam_policy.jenkins_ssm_policy.arn
}

# Create an IAM instance profile
resource "aws_iam_instance_profile" "jenkins_ec2_profile" {
  name = var.instance_profile_name
  role = aws_iam_role.jenkins_ec2_role.name
}

