locals {
    subnet_map = {
        "1" : "web_server",
        "2" : "was",
        "3" : "database",
    }
}

############################## VPC ###############################
resource "aws_vpc" "main_vpc" {
    cidr_block = var.AWS_VPC_CIRD
    instance_tenancy = "default"

    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = "main-vpc"
    }
}

resource "aws_internet_gateway" "main_gw" {
    vpc_id = aws_vpc.main_vpc.id
}

####################### Public Subnet #############################
resource "aws_subnet" "main_public" {
    count = length(var.AWS_AZ_PREFIXS)

    cidr_block = tolist(var.AWS_PUBLIC_SUBNETS)[count.index]
    vpc_id = aws_vpc.main_vpc.id
    availability_zone = join("",["ap-northeast-2", var.AWS_AZ_PREFIXS[count.index]])

    tags = {
        Name = join("",["public_", lookup(local.subnet_map, count.index+1 )])
    }

}

## EIP
resource "aws_eip" "main_mat_eip" {
    count = length(var.AWS_AZ_PREFIXS)
    vpc = true
    tags = {
        Name = join("",["main_nat_eip", lookup(local.subnet_map, count.index+1 )])
    }
}


####################### Private Subnet #############################
resource "aws_subnet" "main-private" {
    count = length(var.AWS_AZ_PREFIXS)

    cidr_block = var.AWS_PRIVATE_SUBNETS[count.index]
    vpc_id = aws_vpc.main_vpc.id
    availability_zone = join("",["ap-northeast-2", var.AWS_AZ_PREFIXS[count.index]])

    tags = {
        Name = join("",["private_",lookup(local.subnet_map, count.index+1 )])
    }
}

resource "aws_nat_gateway" "main-nat-gateway" {
    count = length(var.AWS_AZ_PREFIXS)

    allocation_id = aws_eip.main_mat_eip[count.index].id
    subnet_id = aws_subnet.main_public[count.index].id

    depends_on = [
        aws_internet_gateway.main_gw
    ]
}

resource "aws_route_table" "main_private_rt_table" {
    count = length(var.AWS_AZ_PREFIXS)

    vpc_id = aws_vpc.main_vpc.id

    tags = {
        Name = join("",["private_rt_", lookup(local.subnet_map, count.index+1)])
    }
}

resource "aws_route_table_association" "main_private_rt-associationn" {
    count = length(var.AWS_AZ_PREFIXS)

    subnet_id = aws_subnet.main-private[count.index].id
    route_table_id = aws_route_table.main_private_rt_table[count.index].id
}

resource "aws_route" "nat_gateway_route" {
    count = length(var.AWS_AZ_PREFIXS)

    route_table_id = aws_route_table.main_private_rt_table[count.index].id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main-nat-gateway[count.index].id
}