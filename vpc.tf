module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "4.0.2"

    name = "onprem-vpc"
    cidr = var.vpc_cidr

    azs = [var.az1]
    public_subnets = [var.public]
    private_subnets = [var.private]
    enable_nat_gateway = true
    single_nat_gateway = true
    map_public_ip_on_launch = true
    create_database_subnet_group = false

    tags = {
    Terraform = "true"
    Environment = "dev"
    }
}