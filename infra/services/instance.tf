module vpc {
    source = "../modules/vpc"

    // vars
    env = var.env
    aws_azs = var.aws_azs
    vpc_cidr = var.vpc_cidr
    cidrs_map = var.cidrs_map
    aws_region = lookup(var.aws_credentials,"aws_region")
}