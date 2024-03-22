################
##### IGW  #####
################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_01.id

  tags = {
    Name        = "Test IGW"
    application = "sockshop"
    yor_trace   = "e8d2efb1-a8a7-47b9-98e3-8d77a9ae6fff"
  }
}