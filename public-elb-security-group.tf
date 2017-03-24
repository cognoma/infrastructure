resource "aws_security_group" "cognoma-public-elb" {
  name = "cognoma-public-elb"
  description = "cognoma-public-elb"
  vpc_id = "${aws_vpc.cognoma-vpc.id}"
}

resource "aws_security_group_rule" "cognoma-public-elb-all" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  security_group_id = "${aws_security_group.cognoma-service.id}"
  cidr_blocks = ["0.0.0.0/0"]
}