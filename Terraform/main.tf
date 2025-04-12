provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "trading_vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_eks_cluster" "trading_cluster" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
  }
}

resource "aws_db_instance" "trading_db" {
  allocated_storage = 20
  engine            = "postgres"
  instance_class    = "db.t3.micro"
  username         = var.db_username
  password         = var.db_password
}
