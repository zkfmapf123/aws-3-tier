####################################################### VPC #######################################################
module vpc {
    source = "../modules/vpc"

    // vars
    env = var.env
    aws_azs = var.aws_azs
    vpc_cidr = var.vpc_cidr
    cidrs_map = var.cidrs_map
    aws_region = lookup(var.aws_credentials,"aws_region")

    # output:
    #     public_subnets : list(subnets)
    #     private_subnets : list(subnets)
    #     private_db_subnets : list(subnets)
}
##############################################################################################################

##################################################### 1 Tier #####################################################

module openVPN_sg {
    source = "../modules/security-group/openVPN"

    env = var.env
    vpc_info = module.vpc.vpc_info

    #output:
    #   openVPN_sg_id : string
}


// openVPN EC2 (public-subnet)
module instance {
    source = "../modules/instance"   

    // vars
    env = var.env
    is_security_options = true
    instance_map = {
        ami = lookup(var.aws_ec2_ami_map, "openVPN")
        instance_type = "t2.small",
        security_group_id = module.openVPN_sg.openVPN_sg_id
        subnet_id = module.vpc.public_subnets[0].id
        purpose = "openVPN"   
    }
}

##########################################################################################################