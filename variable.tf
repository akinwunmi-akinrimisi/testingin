variable "region" {
  default = "eu-west-2"
}

variable "cidr_block" {
  default = ["10.0.0.0/16", "10.0.0.0/18", "10.0.64.0/18"]
}

variable "availability_zone" {
  default = ["eu-west-2a", "eu-west-2b"]
}