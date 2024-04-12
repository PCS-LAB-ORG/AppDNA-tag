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
    Application = "AppDNA"
    yor_name    = "PublicWebTemplate"
    yor_trace   = "52e22462-2f9e-493b-98b7-df6301ff9cb5"
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
    Application = "AppDNA"
    yor_name    = "private-app-template"
    yor_trace   = "eec05111-53ae-4629-88e1-6f4520cf6efc"
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




