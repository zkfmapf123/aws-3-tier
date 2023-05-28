variable "aws_azs" {
    type = list(string)
}

variable "vpc_cidr" {
    type = string
}

variable "cidrs_map" {
  type = map(list(string))
}

variable "env" {
  type = string
}

variable "aws_region" {
  type = string
}

