variable "env" {}
variable "subnet_id" {}

resource "aws_eip" "nat_eip" {
    vpc= true
    tags = {
        Name = "${var.env}_nat_eip"
    }
}

resource "aws_nat_gateway" "main_nat" {

    allocation_id = aws_eip.nat_eip.id
    subnet_id = var.subnet_id

    tags = {
        Name = "${var.env}_main_nat_gateway"
    }
}

output aws_nat_gateway_id {
    value = aws_nat_gateway.main_nat.id
}