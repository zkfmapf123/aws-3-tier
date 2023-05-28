# aws_credentials
variable "aws_credentials" {
    type = map(string)

    default = {
      "aws_region" = "",
      "aws_access_key" = "",
      "aws_secret_key" = ""
    }
}

# aws_ec2_ami_map
variable "aws_ec2_ami_map" {
  type = map(string)

  default = {
    openVPN = "",
    was = ""
  }
}


variable "aws_azs" {
    type = list(string)

    default = []
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

