// AWS variables
/*
variable "aws_credentials" {
  default = "$HOME/.aws/credentials"
}

variable "aws_access_key" {} 

variable "aws_secret_key" {} 

variable "aws_role_arn" {} 
*/
  
variable "aws_region" {
  default = "ca-central-1"
}

variable "aws_availability_zone" {
  default = "ca-central-1a"
}

variable "aws_key_name" {
  default = "vce"
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

variable "aws_sg_name" {
  description = "Enter the security group"
  default = "SG"
}

variable "aws_private_ip" {
  description = "Enter the private IP for VCE LAN interface (example: 172.16.100.100)"
  default = "172.36.100.100"
}

variable "aws_instance_type" {
  description = "Enter the instance type (example: c4.large)"
  default = "c4.large"
}

# VeloCloud SD-WAN vEdge (3.3.1)
variable "aws_amis" {
    default = {
        eu-north-1 = "ami-ba9c16c4"
        ap-south-1 = "ami-08df28503c779c65b"
        eu-west-3 = "ami-00bb1d7d48dd45aac"
        eu-west-2 = "ami-0910c04a99eda46f3"
        eu-west-1 = "ami-0f5a1ddf49df24d29"
        ap-northeast-2 = "ami-001c1e312fec38b26"
        ap-northeast-1 = "ami-02028fdfda2bedef3"
        sa-east-1 = "ami-03476bb22664d682d"
        ca-central-1 = "ami-03a3ed427dd6af221"
        ap-southeast-1 = "ami-00b0ac7201061dce6"
        ap-southeast-2 = "ami-0b7196fd587231352"
        eu-central-1 = "ami-0e3ef4a959a447466"
        us-east-1 = "ami-0a9373a4b23e149b7"
        us-east-2 = "ami-00009cd364607db91"
        us-west-1 = "ami-0eae7918e6c5e03e3"
        us-west-2 = "ami-0e2374b672d5149c3"
    }
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

data "aws_security_group" "aws_vcn-sg" {
   filter {
       name = "description"
       values = [var.aws_sg_name]
   }
}
