provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "example" {
  ami           = "ami-b73d6cd7"
  instance_type = "t2.micro"
  count = "5"

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
    instance = "${aws_instance.another.id}"
}

resource "aws_instance" "another" {
  ami = "ami-b73d6cd7"
  instance_type = "t2.micro"
  depends_on = ["aws_instance.example"]
}
