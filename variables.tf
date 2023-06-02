variable "vpc_cidr" {
    type = string
    description = "cidr address"
}

variable "az1" {
    description = "az's added"
}

variable "public" {
    description = "publicsubnet"
}

variable "private" {
    description = "privatesubnet"
}

variable "ami_for_app" {
    description = "ami"
}
variable "mysql_root_password" {
    description = "rootpassword"
}
# variable "peer_owner_id" { 
# }