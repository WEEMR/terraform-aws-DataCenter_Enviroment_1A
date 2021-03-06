# Access and secret keys to your environment
variable "access_key" {}
variable "secret_key" {}

# AWS Key Name to create Resources

variable "keyname" {}

# FortiGate Username and Password
variable "username" {}
variable "Password" {}

# Region 
variable "virginia_region" {}


# DNS Zone ID
variable "Public_SubHosted_Zone_id" {}

# Global Dependencies

variable "default_SG" {}
variable "Public_SG" {}
variable "Private_SG" {}

# Spoke 1 Subnet IDs Dependencies

variable "spoke_1_wan1_subnet_id" {}

variable "spoke_1_wan2_subnet_id" {}

variable "spoke_1_private_subnet_id" {}

variable "spoke_1_pvt_rt_id" {}

# Spoke 1 Subnets CIDR Blocks

variable "spoke_1_wan1_subnet_cidr" {}

variable "spoke_1_wan2_subnet_cidr" {}

variable "spoke_1_private_subnet_cidr" {}

# Spoke 1 Interfaces IPs 

variable "spoke_1_wan1_pvt_ip" {}

variable "spoke_1_wan2_pvt_ip" {}

variable "spoke_1_lan_pvt_IP" {}

# Linux Interface IP 

variable "spoke_1_Ubuntu_LAN_IP" {}

# Windows Server Interface IP

variable "spoke_1_WinSrv_LAN_IP" {}


# -------------------------------------------------------------- AMIs

# FortiGate AMI

variable "FGT_VM_AMI" {
  description = "FortiGate FGTVM-AWS(PAYG) - 7.0.3 AMI"
  type        = map
  default = {
    us-east-1 = "ami-099e9f57e31ec423c"
  }
}

// Ubuntu 20.04 LTS
variable "Ubuntu_WebServer_AMI" {
  description = "Ubuntu 20.04 LTS AMI"
  type        = map
  default = {
    us-east-1 = "ami-042e8287309f5df03"
  }
}

// AMIs are for WinSrv2019-Base
variable "WinSrv2019_ami" {
  type = map
  default = {
    us-east-1      = "ami-0aad84f764a2bd39a"
  }
}

# -------------------------------------------------------------- VM Sizes

# FortiGate VM Size

variable "FGT_VM_Size" {
  description = "FGT Instance Size"
  default     = "t3.small"
}

# Ubuntu VM Size

variable "Ubuntu_VM_Size" {
  description = "Ubuntu Instance Size"
  default     = "t3.micro"
}

# Windows VM Size

variable "WinSrv_VM_Size" {
  description = "Windows Server Instance Size"
  default     = "t3.medium"
}

# -------------------------------------------------------------- FGT Configuration File

variable "Spoke1_Configurations" {
  type    = string
  default = "Spoke1_fgtvm.conf"
}

# -------------------------------------------------------------- Windows Server Configuration File

variable "Windows_Server2019_Config" {
  type = string
  default = "./WinSrv_conf"
}
