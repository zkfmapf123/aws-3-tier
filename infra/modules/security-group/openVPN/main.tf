variable "env" {

}

variable "vpc_info" {

}

resource "aws_security_group" "openVPN_sg" {
    name = "openVPN_sg"
    description = "purpose of openVPN"
    vpc_id = var.vpc_info.id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.vpc_info.cidr_block]
    }

    ingress {
        from_port   = 943
        to_port     = 943
        protocol    = "tcp"
        cidr_blocks = [var.vpc_info.cidr_block]
    }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = [var.vpc_info.cidr_block]
    }

    ingress {
        from_port   = 1194
        to_port     = 1194
        protocol    = "udp"
        cidr_blocks = [var.vpc_info.cidr_block]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.env}_sg_openVPN"
    }
}

output openVPN_sg_id {
    value = aws_security_group.openVPN_sg.id
}