variable "availability" {}

resource "aws_vpc" "hubot-vpc-us-east" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "hubot-gateway-us-east" {
  vpc_id = "${aws_vpc.hubot-vpc-us-east.id}"
}

resource "aws_route_table" "hubot-route-table-us-east" {
  vpc_id = "${aws_vpc.hubot-vpc-us-east.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.hubot-gateway-us-east.id}"
  }
}

resource "aws_security_group" "hubot-security-group-us-east" {
  name = "hubot-security-group-us-east"
  vpc_id = "${aws_vpc.hubot-vpc-us-east.id}"

  ingress {
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 8080
    to_port = 8081
  }

  ingress {
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 443
    to_port = 443
  }

  ingress {
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
  }

  ingress {
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 3389
    to_port = 3389
  }

  ingress {
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 49152
    to_port = 65535
  }

  egress {
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 8080
    to_port = 8081
  }

  egress {
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 443
    to_port = 443
  }

  egress {
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 49152
    to_port = 65535
  }
}

resource "aws_network_acl" "hubot-network-acl-us-east" {
  vpc_id = "${aws_vpc.hubot-vpc-us-east.id}"

  ingress {
    protocol = "tcp"
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 8080
    to_port = 8081
  }

  ingress {
    protocol = "tcp"
    rule_no = 120
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 443
    to_port = 443
  }

  ingress {
    protocol = "tcp"
    rule_no = 130
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 22
    to_port = 22
  }

  ingress {
    protocol = "tcp"
    rule_no = 140
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 3389
    to_port = 3389
  }

  ingress {
    protocol = "tcp"
    rule_no = 150
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 49152
    to_port = 65535
  }

  egress {
    protocol = "tcp"
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 8080
    to_port = 8081
  }

  egress {
    protocol = "tcp"
    rule_no = 120
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 443
    to_port = 443
  }

  egress {
    protocol = "tcp"
    rule_no = 130
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 49152
    to_port = 65535
  }
}

resource "aws_subnet" "hubot-subnet-us-east" {
  availability_zone = "${var.availability}"
  map_public_ip_on_launch = true
  vpc_id = "${aws_vpc.hubot-vpc-us-east.id}"
  cidr_block = "10.0.1.0/24"
}

resource "aws_route_table_association" "hubot-route-table-association-us-east" {
  subnet_id = "${aws_subnet.hubot-subnet-us-east.id}"
  route_table_id = "${aws_route_table.hubot-route-table-us-east.id}"
}

output "internet_gateway" {
  value = "${aws_internet_gateway.hubot-gateway-us-east.id}"
}

output "subnet_id" {
  value = "${aws_subnet.hubot-subnet-us-east.id}"
}

output "security_group" {
  value = "${aws_security_group.hubot-security-group-us-east.id}"
}