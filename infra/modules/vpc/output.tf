output vpc_info {
    value = aws_vpc.main_vpc
}

output public_subnets {
    value = aws_subnet.main_public_subnet
}

output private_subnets {
    value = aws_subnet.main_private_subnet
}

output private_db_subnets {
    value = aws_subnet.main_private_db_subnet
}