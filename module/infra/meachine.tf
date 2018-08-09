//ec2 creation

resource "aws_instance" "web1" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
  subnet_id     = "${var.subnet1_id}"
  key_name = "devops"
  vpc_security_group_ids = ["${var.security_group1}","${var.security_group2}"]


  tags {
    Name = "student-ec2-1"
  }
}

resource "aws_instance" "web2" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
  subnet_id     = "${var.subnet2_id}"
  key_name = "devops"
  vpc_security_group_ids = ["${var.security_group1}","${var.security_group2}"]


  tags {
    Name = "student-ec2-2"
  }
}

// Create a new load balancer

resource "aws_elb" "elb" {
  name               = "student-terraform-elb"
  subnets     = ["${var.subnet1_id}","${var.subnet2_id}"]
  // availability_zones = ["us-east-1a", "us-east-1b"]
  security_groups = ["${var.security_group2}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = ["${aws_instance.web1.id}", "${aws_instance.web1.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "student-lb"
  }
}
