provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "web1" {
  ami           = "ami-d8bdebb8"
  instance_type = "t2.micro"
  count = "2"

  user_data = <<-EOF
            #!/bin/bash
            echo "Hello, World" > index.html
            nohup busybox httpd -f -p 8080 &
            EOF

  tags {
    Name = "webserver-1"
  }
}

resource "aws_eip" "ip" {
    instance = "${aws_instance.web1.id}"
}
