# Terraform 0.12 compliant
provider "aws" {
  region = var.aws_region
}

# network
resource "aws_vpc" "test-env" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_eip" "ip-test-env" {
  instance = aws_instance.test-ec2-instance.id
  vpc      = true
}

# subnets
resource "aws_subnet" "subnet-uno" {
  cidr_block        = cidrsubnet(aws_vpc.test-env.cidr_block, 3, 1)
  vpc_id            = aws_vpc.test-env.id
  availability_zone = "us-east-1a"
}

# gateways
resource "aws_internet_gateway" "test-env-gw" {
  vpc_id = aws_vpc.test-env.id
}

# route table
resource "aws_route_table" "route-table-test-env" {
  vpc_id = aws_vpc.test-env.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-env-gw.id
  }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.subnet-uno.id
  route_table_id = aws_route_table.route-table-test-env.id
  }
}

output "elastic_IP_address" {
  value = ["${aws_eip.ip-test-env.public_ip}"]
}
