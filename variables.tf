variable "name" {
  description = "nombre al recurso"
  type        = string
  default     = "juan"
}

variable "environment" {
  type = string
  default = "dev"
}

variable "vpcid" {
    type = string
    default = "vpc-0fde2e0a149541970"
}

variable "subnetid" {
    type = string
    default = "subnet-04f72fd23f513d4e0"
}

variable "keyname" {
    type = string
    default = "juankeys"
}