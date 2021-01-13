variable "key_name" {
  default = ""
}
variable "volume_tags" {
  default = ""
}
variable "volume_size" {
  default = ""
}
variable "user_data" {
  default = ""
}
variable "tags" {
  default = ""
}
resource "aws_instance" "instance" {
  ami = "ami-0885b1f6bd170450c"
  instance_type = "t2.micro"
  key_name = var.key_name
  security_groups = [
    var.sec_group_name,
  ]
  tags = var.tags
  volume_tags = var.volume_tags
  vpc_security_group_ids = [
    aws_security_group.instance.id,
  ]
  root_block_device {
    volume_size = var.volume_size
  }
  user_data = filebase64(var.user_data)
}

variable "sec_group_name" {
  default = ""
}
variable "sec_group_description" {
  default = ""
}
variable "port_list" {
  default = ""
}
variable "ip_list" {
  default = ""
}
resource "aws_security_group" "instance" {
  description = var.sec_group_description
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description = ""
      from_port = 0
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      protocol = "-1"
      security_groups = []
      self = false
      to_port = 0
    },
  ]
  ingress = [
  for _port in var.port_list:
  {
    cidr_blocks = [
    for _ip in var.ip_list:
    _ip
    ]
    description = ""
    from_port = _port
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "tcp"
    security_groups = []
    self = false
    to_port = _port
  }
  ]
  name = var.sec_group_name
}