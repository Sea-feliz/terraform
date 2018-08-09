output "subnet1_id" {
    value = "${aws_subnet.subnet1.id}"
}

output "subnet2_id" {
    value = "${aws_subnet.subnet2.id}"
}

output "security_group1" {
	value = "${aws_security_group.allow_ssh.id}"
}

output "security_group2" {
	value = "${aws_security_group.allow_web.id}"
}