module vpc {
    source = "../modules/vpc"

    aws_region = var.aws_region
    env = var.env
    vpc_cidr = var.vpc_cidr
    azs = var.azs
    cidrs = var.cidrs
}