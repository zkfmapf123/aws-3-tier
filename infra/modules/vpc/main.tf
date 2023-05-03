locals {
    az_names = [for suffix in var.azs : "${var.aws_region}${suffix}"]

    subnet_purpose = {
        0 : "dev" 
        1 : "stage"
        2 : "prod"
    }
}

#################################### VPC #####################################
resource "aws_vpc" "main_vpc" {
    cidr_block  = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = join("",["main_vpc_",var.env])
    }
}

##### Internet Gateway #####
resource "aws_internet_gateway" "main_igw" {
    vpc_id = aws_vpc.main_vpc.id

    tags = {
        Name = join("",["main_igw_",var.env])
    }
}
#############################################################################


############################# Public Subnet #################################
resource "aws_subnet" "webserver" {
    count = length(var.cidrs["public"])

    vpc_id = aws_vpc.main_vpc.id
    cidr_block = var.cidrs["public"][count.index]
    availability_zone = local.az_names[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = join("", ["webserver_", local.subnet_purpose[count.index]])
    }
}
#############################################################################

############################# Private Subnet #################################
resource "aws_subnet" "was" {
    count = length(var.cidrs["private"])

    vpc_id = aws_vpc.main_vpc.id
    cidr_block = var.cidrs["private"][count.index]
    availability_zone = local.az_names[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = join("", ["was_", local.subnet_purpose[count.index]])
    }
}
#############################################################################

############################# Database Subnet #################################
resource "aws_subnet" "database" {
    count = length(var.cidrs["database"])

    vpc_id = aws_vpc.main_vpc.id
    cidr_block = var.cidrs["database"][count.index]
    availability_zone = local.az_names[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = join("", ["database_", local.subnet_purpose[count.index]])
    }
}
#############################################################################
