resource "aws_security_group" "efs_sg" {
  name        = "efs-sg"
  description = "Security group for EFS to allow NFS traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow NFS traffic on port 2049 from any source"
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    protocol = "NFS"
  }
}

resource "aws_efs_file_system" "jenkins" {
  creation_token = "jenkins"
  encrypted      = true
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  tags = {
    Name = "jenkins-efs"
  }
}

resource "aws_efs_mount_target" "jenkins" {
  count = length(var.subnet_ids)
  file_system_id   = aws_efs_file_system.jenkins.id
  subnet_id        = var.subnet_ids[count.index]
  security_groups = [aws_security_group.efs_sg.id]
}