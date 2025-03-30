provider "aws" {
    region = "us-east-1"  
}
resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "mysubnet" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch =  true
}
resource "aws_internet_gateway" "myigw" {
    vpc_id = aws_vpc.myvpc.id
}
resource "aws_route_table" "myroutetable" {
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myigw.id
}
}
resource "aws_route_table_association" "myroutetableassociation" {
    subnet_id = aws_subnet.mysubnet.id
    route_table_id = aws_route_table.myroutetable.id
}
resource "aws_security_group" "mysecuritygroup" {
    name = "mysecuritygroup"
    vpc_id = aws_vpc.myvpc.id
    ingress {
        description = "Allow web inbound traffic and all outbound traffic"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_instance" "myinstance" {
    ami = "ami-04b4f1a9cf54c11d0"
    instance_type = "t2.micro"
    key_name = "aws"
    subnet_id = aws_subnet.mysubnet.id
    tags = {Name = "Application server"}
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.mysecuritygroup.id]

    user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y openjdk-17-jdk
              EOF
}
resource "aws_s3_bucket" "terraform-state" {
  bucket = "my-terraform-state-bucket-vijay-2025"
}
resource "aws_s3_bucket" "terraform" {
  bucket = "terraform-vijay"
}
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}
terraform {
    backend "s3" {
        bucket = "my-terraform-state-bucket-vijay-2025"
        key = "terraform.tfstate"
        region = "us-east-1"
        encrypt = true
}
}
output "aws_instance_private_ip" {
    value = aws_instance.myinstance.private_ip
}
output "aws_instance_public_ip" {
    value = aws_instance.myinstance.public_ip
}
output "name" {
    value = aws_instance.myinstance.tags.Name
}