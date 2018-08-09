//aws vpc creation
resource "aws_vpc" "main" {
  cidr_block = "${var.cidr}"

  tags {
    Name = "${var.project_name}-vpc"
  }
}

//creating igw

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.project_name}-igw"
  }
}


//Subnet creation

resource "aws_subnet" "subnet1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.cidr_block1}"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"

  tags {
    Name = "${var.project_name}-subnet1"
  }
}

//creating second subnet
resource "aws_subnet" "subnet2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.cidr_block2}"
  availability_zone = "us-east-1b"

  tags {
    Name = "${var.project_name}-subnet2"
  }
}

//route cable creation

resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "studentapp"
  }
}

//assigning subnetes to route table

resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.subnet1.id}"
  route_table_id = "${aws_route_table.main.id}"
}

resource "aws_route_table_association" "b" {
  subnet_id      = "${aws_subnet.subnet2.id}"
  route_table_id = "${aws_route_table.main.id}"
}

//Creating Security group

resource "aws_security_group" "allow_ssh" {
  name        = "Allow SSH"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
 }
  tags {
    Name = "student_app"
  }
}

// Security Group for allowing WEB Access for ELB
resource "aws_security_group" "allow_web" {
  name        = "Allow Web"
  description = "Allow HTTP inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}