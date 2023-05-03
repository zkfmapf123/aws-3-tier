variable "aws_region" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "env" {}

variable "vpc_cidr" {}
variable "azs" { 
    type = list(string)
}
variable "cidrs" {
    type = map(list(string))
}
