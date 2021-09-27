//AWS Configuration
variable access_key {} #  IAM Account Access Key
variable secret_key {} #  IAM Account Secret Key
variable username {}   #  Resources name Prefix & FGT admin & VPN Username - should be your 1st Initial, Last Name to tag resources
variable keyname {}    #  Existing SSH Key on the AWS
variable Password {}   #  FGT Admin Password & VPN user Passsword


# ------------------------------------------------------ DNS ------------------------------------------------------------ #

variable Public_Hosted_Zone {}     # you must have your domain registerd with AWS Route53 or AWS manages the domain DNS i.e xyz.com 
variable SubHosted_Zone {} # Create a private Sub-Hosted Zone for the domain name i.e lab.xyz.com (private & Public)

variable "Region" {
  default = "us-east-1"
}

variable "USEast1_VPC" {
  description = "The CIDR block of the VPC"
  default     = "10.150.0.0/16"
}

variable "virginia_public_subnet_1" {
  description = "Public subnet 1"
  default     = "10.150.1.0/24"
}

variable "virginia_public_subnet_2" {
  description = "Public subnet 2"
  default     = "10.150.2.0/24"
}

variable "virginia_private_subnet_1" {
  description = "Private subnet 1"
  default     = "10.150.5.0/24"
}

// FGT eth0 (WAN) Interface IP 
variable "FGT_WAN_IP" {
  description = "FortiGate Port 1 (WAN) Private IP"
  default     = ["10.150.1.10"]
}

// FGT eth1 (LAN) Interface IP 
variable "FGT_LAN_IP" {
  description = "FortiGate Port 2 (LAN) Private IP"
  default     = ["10.150.5.5"]
}

// FMG eth0 (WAN) Interface IP 
variable "FMG_LAN_IP" {
  description = "FortiManager Port 1 (WAN) Private IP"
  default     = ["10.150.1.20"]
}

// Ubuntu eth0 (LAN) Interface IP 
variable "Ubuntu_LAN_IP" {
  description = "Ubunutu Apache Server eth0 Private IP"
  default     = ["10.150.5.10"]
}


// AMIs are for FGTVM-AWS(PAYG) - 7.0
variable "FGT_VM_AMI" {
  description = "FortiGate FGTVM-AWS(PAYG) - 7.0 AMI"
  type        = map
  default = {
    us-east-1 = "ami-01a54d044634cf0f6"
  }
}

// AMIs are for FMG AWS (2 Devices) - 6.4.5
variable "FMG_VM_AMI" {
  description = "FMG AWS (2 Devices) - 6.4.5 AMI"
  type        = map
  default = {
    us-east-1 = "ami-03389c3d9b8f13b32"
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


variable "FMG_VM_Size" {
  description = "FMG Instance Size"
  default     = "t3.medium"
}

variable "FGT_VM_Size" {
  description = "FGT Instance Size"
  default     = "t3.small"
}

variable "Ubuntu_VM_Size" {
  description = "Ubuntu Instance Size"
  default     = "t3.micro"
}


variable "adminsport" {
  description = "FortiGate Administration Port"
  default     = "443"
}

variable "bootstrap-fgtvm" {
  type    = string
  default = "fgtvm.conf"
}



// Security Groups 


variable "Public_SG" {
  description = "Public Security Group used by dynamic block at network.tf"
  default = [
    {
      port        = 22
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 443
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 8443
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 10443
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 0
      proto       = "1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
