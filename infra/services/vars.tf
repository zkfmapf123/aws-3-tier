# aws_credentials
variable "aws_credentials" {
    type = map(string)

    default = {
      "aws_region" = "",
      "aws_access_key" = "",
      "aws_secret_key" = ""
    }
}

variable "aws_azs" {
    type = list(string)

    default = []
}