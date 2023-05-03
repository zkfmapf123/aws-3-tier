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

resource "aws_route_table" "webserver_route_table" {
    vpc_id = aws_vpc.main_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main_igw.id
    }

    tags = {
        Name = "web_server_route_table"
    }
}

## Public Subnet의 개수만큼 RT Table에 Assoication
resource "aws_route_table_association" "webserver_route_table_association" {
    count = length(var.cidrs["public"])

    subnet_id = aws_subnet.webserver[count.index].id
    route_table_id = aws_route_table.webserver_route_table.id
}

## eip
resource "aws_eip" "main_eip" {
    count = length(var.cidrs["public"]) > 0 ? 1 : 0

    depends_on = [aws_internet_gateway.main_igw]
    vpc = true
}

## Nat Gateway
# resource "aws_nat_gateway" "main_nat_gateway" {
#     count = length(var.cidrs["public"]) > 0 ? 1 : 0

#     depends_on = [aws_internet_gateway.main_igw]

#     allocation_id = try(aws_eip.main_eip[0].id, "")
#     subnet_id = try(var.cidrs["public"][0].id,"") 

#     tags = {
#         Name = join("",["main_nat_gateway_",count.index, "_", local.subnet_purpose[count.index]])
#     }
# }

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
