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

