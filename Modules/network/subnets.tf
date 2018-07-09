resource "aws_subnet" "subnet1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.subnet1_cidr}"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"
  tags {
    Name = "${var.project_name}-subnet1"
  }
}


resource "aws_subnet" "subnet2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.subnet2_cidr}"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "true"
  tags {
    Name = "${var.project_name}-subnet2"
  }
}