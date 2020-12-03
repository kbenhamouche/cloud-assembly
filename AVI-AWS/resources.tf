// ----- AVI Section ----- //

/* STEPS
0- Create the AWS Cloud Connector
1- Define Pool Servers for public clouds
2- Define the VIP@ for public clouds
3- Define the Virtual Services with WAF for public clouds
*/

data "avi_ipamdnsproviderprofile" "dns_profile" {
   name = "AVI-DNS-Profile"
}

data "avi_ipamdnsproviderprofile" "ipam_profile" {
   name = "VIP-AVI-IPAM"
}

data "avi_applicationprofile" "system_http" {
   name = "System-HTTP"
}

data "avi_networkprofile" "system_tcp_proxy" {
   name = "System-TCP-Proxy"
}

// Create AWS Cloud Connector
resource "avi_cloud" "aws_cloud" {
   name = var.aws_cloud_name
   vtype = "CLOUD_AWS"
   dns_provider_ref = data.avi_ipamdnsproviderprofile.dns_profile.id
   dhcp_enabled = true
   license_tier = "ENTERPRISE"
   license_type = "LIC_CORES"
   
   aws_configuration {
      region = var.aws_region
      secret_access_key = var.aws_secret_key
      access_key_id = var.aws_access_key
      //iam_assume_role = var.aws_role_arn
      route53_integration = false
      s3_encryption {}
      zones {
         availability_zone = var.aws_availability_zone
         mgmt_network_name = data.aws_subnet.aws_vcn-private-sn.tags.Name
         mgmt_network_uuid = data.aws_subnet.aws_vcn-private-sn.id
      }
      vpc = data.aws_vpc.aws_vcn-vpc.tags.Name
      vpc_id = data.aws_vpc.aws_vcn-vpc.id
   }
}

// 1- Define the HTTP Pool Servers

resource "avi_pool" "aws_http_pool" {
    name = var.aws_pool
    lb_algorithm = "LB_ALGORITHM_ROUND_ROBIN"
    cloud_ref = avi_cloud.aws_cloud.id
    default_server_port = 80
    servers {
        ip {
            type = "V4"
            addr = var.aws_web-vm1
        }
    }
    servers {
        ip {
            type = "V4"
            addr = var.aws_web-vm2
        }
    }
    analytics_policy {
     enable_realtime_metrics = true
   }
}

// 2- Define the VIP@

resource "avi_vsvip" "aws_vsvip" {
    depends_on = [aws_instance.aws_velo-instance]
    name = var.aws_vs_name
    cloud_ref = avi_cloud.aws_cloud.id
    vip {
        auto_allocate_floating_ip = true
        auto_allocate_ip  = true
        subnet_uuid = data.aws_subnet.aws_vcn-private-sn.id
        subnet {
            ip_addr {
                addr = data.aws_subnet.aws_vcn-private-sn.cidr_block
                type = "V4"
            }
            mask = "24"
        }
    }
    dns_info {
      fqdn = var.aws_domain_name
    }
}