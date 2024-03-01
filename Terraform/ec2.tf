########################
###    Data source   ###
########################

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}
########################
###    Ec2 Instance  ###
########################


resource "aws_instance" "PublicWebTemplate" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public-web-subnet-1.id
  vpc_security_group_ids = [aws_security_group.webserver-security-group.id]
  key_name               = "source_key"
  user_data              = file("install-apache.sh")

  tags = {
    Name        = "web-asg"
    app         = "Application A"
    application = "sockshop"
    yor_trace   = "d2b4ac8d-8d41-4cbe-8f52-2ba8fadcdd18"
  }
}



##############################
#### EC2 instance Web Tier ###
##############################

/*resource "aws_instance" "PublicWebTemplate" {
  ami                    = "ami-052efd3df9dad4825"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public-web-subnet-1.id
  vpc_security_group_ids = [aws_security_group.webserver-security-group.id]
  key_name               = "source_key"
  user_data              = file("install-apache.sh")

  tags = {
    Name = "web-asg"
  }
}*/


resource "aws_instance" "private-app-template" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private-app-subnet-1.id
  vpc_security_group_ids = [aws_security_group.ssh-security-group.id]
  key_name               = "source_key"

  tags = {
    Name        = "app-asg"
    application = "sockshop"
    yor_trace   = "ca54c7be-8d8c-427b-8c1c-6f2338b4e95c"
  }
}

##############################
#### EC2 instance App Tier ###
##############################

/*resource "aws_instance" "private-app-template" {
  ami                    = "ami-052efd3df9dad4825"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private-app-subnet-1.id
  vpc_security_group_ids = [aws_security_group.ssh-security-group.id]
  key_name               = "source_key"

  tags = {
    Name = "app-asg"
  }
}*/




