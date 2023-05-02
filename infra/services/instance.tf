## VPC Environment 
module vpc {
    source = "../modules/vpc"

    aws_region = var.aws_region
    env = var.env
    vpc_cidr = var.vpc_cidr
    azs = var.azs
    cidrs = var.cidrs
}

## 1 Tier WebServer
module "public_webserver" {
    source ="../modules/webserver"

    instance_map = {
        ami = "ami-04cebc8d6c4f297a3"
        instance_type = "t3.micro"
    }

    subnet_ids = {
        public = module.vpc.public_subnet_ids
        private = null
    }

    vpc_id = module.vpc.vpc_id
    env = var.env
}

## 2 Tier WAS Server
module "private_was" {
    source= "../modules/was"

    instance_map = {
        ami = "ami-04cebc8d6c4f297a3"
        instance_type = "t3.micro"
    }

    subnet_ids = {
        public = module.vpc.public_subnet_ids
        private = module.vpc.was_subnet_ids
    }

    vpc_id = module.vpc.vpc_id
    env = var.env
}

## 3 Tier Database Server
// Later...