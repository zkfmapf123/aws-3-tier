variable instance_map {
    type = map(string)

    default = {
        ami = "",
        instance_type = "",
        security_group_id = ""
        subnet_id = "",
        purpose = ""
    }
}

variable env {}
variable is_security_options {}