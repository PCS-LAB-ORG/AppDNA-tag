#####################
#   NAT Gateway #
#####################

resource "aws_eip" "eip_nat" {
  vpc = true

  tags = {
    Name        = "eip1"
    application = "sockshop"
    yor_trace   = "d955dbb6-963a-4b3f-9177-29539a2984f5"
  }
}

resource "aws_nat_gateway" "nat_1" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = aws_subnet.public-web-subnet-2.id

  tags = {
    "Name"      = "nat1"
    application = "sockshop"
    yor_trace   = "3a06d034-8d9c-4a29-9347-14bd15544817"
  }
}