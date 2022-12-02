########################################
# Metadata
########################################
variable "region" {
  type = string
}

variable "app_name" {
  type = string
}

variable "profile_name" {
  type = string
}

########################################
# VPC
########################################
variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  default     = "0.0.0.0/0"
}

variable "azs" {
  description = "Number of availability zones to use in the region"
  type        = list(string)

}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  default     = []
}

variable "private_subnets" {
  description = "A list of public subnets inside the VPC"
  default     = []
}


########################################
# EKS
########################################


variable "cluster-name" {
  default = "terraform-eks-demo"
  type    = string
}

variable "node1-name" {
  default = "sre-pool-main"
  type    = string
}

variable "node2-name" {
  default = "sre-pool-sec"
  type    = string
}


variable "node1_min_size" {
  description = "Minimum number of instances/nodes"
  type        = number
  default     = 0
}

variable "node1_max_size" {
  description = "Maximum number of instances/nodes"
  type        = number
  default     = 3
}

variable "node1_desired_size" {
  description = "Desired number of instances/nodes"
  type        = number
  default     = 1
}


variable "node2_min_size" {
  description = "Minimum number of instances/nodes"
  type        = number
  default     = 0
}

variable "node2_max_size" {
  description = "Maximum number of instances/nodes"
  type        = number
  default     = 3
}

variable "node2_desired_size" {
  description = "Desired number of instances/nodes"
  type        = number
  default     = 1
}