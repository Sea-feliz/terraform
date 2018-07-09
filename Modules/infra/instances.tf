variable "subnet1_id" {}

resource "aws_instance" "web" {
  ami           = "ami-6871a115"
  instance_type = "t2.micro"
  subnet_id = "${var.subnet1_id}"
  vpc_security_group_ids = "[${aws_security_group.allow_ssh.id}]"
  tags {
    Name = "student"
  }
}

