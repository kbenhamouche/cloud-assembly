// AWS variables

variable "aws_access_key" {} 

variable "aws_secret_key" {} 

//variable "aws_role_arn" {} 
  
variable "aws_region" {
  default = "ca-central-1"
}

variable "aws_availability_zone" {
  default = "ca-central-1a"
}

variable "aws_vpc_name" {
  description = "Enter the VPC name"
  default = "VPC"
}

variable "aws_public_sn_name" {
  description = "Enter the public subnet name"
  default = "PUBLIC-SUBNET"
}

variable "aws_private_sn_name" {
  description = "Enter the private subnet name"
  default = "PRIVATE-SUBNET"
}

// AWS Data
data "aws_vpc" "aws_vcn-vpc" {
   filter {
        name = "tag:Name"
        values = [var.aws_vpc_name]
   }
}

data "aws_subnet" "aws_vcn-public-sn" {
   filter {
        name = "tag:Name"
        values = [var.aws_public_sn_name]
   }
}

data "aws_subnet" "aws_vcn-private-sn" {
    filter {
        name = "tag:Name"
        values = [var.aws_private_sn_name]
    }
}

// AVI Variables
variable "avi_controller" {
  default = "10.5.99.170"
}
variable "avi_username" {
  default = "admin"
} 
variable "avi_password" {
  default = "VMware1!"
} 

variable "avi_tenant" {
  default = "admin"
}

variable "aws_cloud_name" {
  default = "AWS-vRA"
}

variable "aws_private_sn" {
  description = "Enter the private subnet (example: 172.16.100.0/24)"
  default = "172.36.100.0"
}

variable "aws_pool" {
  default = "aws-http-Pool"
}

variable "aws_vs_name" {
  default = "web-aws-cloud-vs"
}

variable "aws_domain_name" {
  default = "web-aws-cloud-vs.ovn.ca"
}

variable "aws_web-vm1" {
  default = "1.1.1.1"
}

variable "aws_web-vm2" {
  default = "1.1.1.2"
}
