## AWS_EIP
resource "aws_eip" "ec2_eip" {
    vpc = true
    instance= aws_instance.main_ec2.id
    tags = {
        Name = "${var.env}_ec2_eip_${lookup(var.instance_map,"purpose")}"
    }
}

## AWS_KEY_PAIR
resource "aws_key_pair" "leedonggyu" {
    key_name = "leedonggyu"
    public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "main_ec2" {

    ami = lookup(var.instance_map,"ami")
    instance_type = lookup(var.instance_map,"instance_type")
    subnet_id = lookup(var.instance_map,"subnet_id")
    vpc_security_group_ids = var.is_security_options ? [lookup(var.instance_map,"security_group_id")] : []
    key_name = aws_key_pair.leedonggyu.key_name

    tags = {
        Name = join("", [var.env, "_", "ec2_", lookup(var.instance_map, "purpose")])
    }
}