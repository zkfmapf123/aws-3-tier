## AWS Credentials
variable "AWS_ACCESS_KEY" {
    type = string
}

variable "AWS_SECRET_KEY" {
    type = string
}

variable "AWS_REGION" {
    type = string
}


## VPC
variable "AWS_VPC_CIRD" {
    type = string
}

variable "AWS_AZ_PREFIXS" {
    type = list(string)
}

variable "AWS_PRIVATE_SUBNETS" {
    type = list(string)
}

variable "AWS_PUBLIC_SUBNETS" {
    type = list(string)
}
