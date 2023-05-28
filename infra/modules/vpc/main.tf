locals {
    az_names = [for suffix in var.aws_azs : "${var.aws_region}${suffix}"]

    pubilc_subnets = var.cidrs_map["public"]
    private_subnets = var.cidrs_map["private"]
    private_db_subnets = var.cidrs_map["db"]
}

#### VPC ####
resource "aws_vpc" "main_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = "${var.env}_main_vpc"
    }
}

#### IGW ####
resource "aws_internet_gateway" "main_igw" {
    vpc_id = aws_vpc.main_vpc.id

    tags = {
        Name = "${var.env}_main_igw"
    }
}

#### Public Subnet (Common) ####
resource "aws_subnet" "main_public_subnet" {
    count = length(local.az_names)

    vpc_id = aws_vpc.main_vpc.id
    cidr_block = local.pubilc_subnets[count.index]
    availability_zone = local.az_names[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.env}_public_subnet_${local.az_names[count.index]}"
    }
}

#### Private Subnet (Common) ####
resource "aws_subnet" "main_private_subnet" {
    count = length(local.az_names)

    vpc_id = aws_vpc.main_vpc.id
    cidr_block = local.private_subnets[count.index]
    availability_zone = local.az_names[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.env}_private_subnet_${local.az_names[count.index]}"
    }
}

#### Private DB Subnet (Common) ####
resource "aws_subnet" "main_private_db_subnet" {
    count = length(local.az_names)

    vpc_id = aws_vpc.main_vpc.id
    cidr_block = local.private_db_subnets[count.index]
    availability_zone = local.az_names[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.env}_private_db_subnet_${local.az_names[count.index]}"
    }
}
