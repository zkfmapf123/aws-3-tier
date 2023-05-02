## Availability Zone
variable "AWS_VPC_CIRD" {
    type = string
}

variable "AWS_AZ_PREFIXS" {
    type = list(string)
}   

## Subnet Private Cidr Block
variable "AWS_PRIVATE_SUBNETS" {
    type = list(string)
}

## Subnet Public Cidr Block
variable "AWS_PUBLIC_SUBNETS" {
    type = list(string)
}



