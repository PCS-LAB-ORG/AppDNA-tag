################
##### VPC  #####
################


resource "aws_vpc" "vpc_01" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name        = "central-network"
    application = "sockshop"
    yor_trace   = "ae50c92f-d674-48d6-ab9e-ddb9170571fa"
  }
}















