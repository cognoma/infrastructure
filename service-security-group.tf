resource "aws_security_group" "cognoma-service" {
  name = "cognoma-service"
  description = "cognoma-service"
  vpc_id = "${aws_vpc.cognoma-vpc.id}"
}

resource "aws_security_group_rule" "cognoma-service-http" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  self = true
  security_group_id = "${aws_security_group.cognoma-service.id}"
}

resource "aws_security_group_rule" "cognoma-service-custom" {
  type = "ingress"
  from_port = 8000
  to_port = 8000
  protocol = "tcp"
  self = true
  security_group_id = "${aws_security_group.cognoma-service.id}"
}

resource "aws_security_group_rule" "cognoma-service-ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.cognoma-service.id}"
}