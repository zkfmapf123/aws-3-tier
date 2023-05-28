variable "vpc_id" {
  type = string
}

variable "env" {
  type =string
}

resource "aws_internet_gateway" "main_igw" {
    vpc_id = var.vpc_id

    tags = {
        Name = "${var.env}_main_igw"
    }
}