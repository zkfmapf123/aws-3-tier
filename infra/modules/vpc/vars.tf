variable "aws_region" {
  type = string
}

variable "env" {
    type = string
}

variable "vpc_cidr" {
    type = string
}

variable "azs" {
  type = list(string)
}

/*
    public
    private
    database
*/
variable "cidrs" {
  type = map(list(string))
}
