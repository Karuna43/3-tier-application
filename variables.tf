variable "rg" {
  description = "name of rg "
  type        = string
  default     = "rg_tech_challenge"
}

variable "location" {
  description = "specify the location"
  type        = string
  default     = "eastus"
}

variable "vnet" {
  description = "name of vent"
  type        = string
  default     = "vnet11"
}

variable "subnet" {
  description = "name of subnet"
  type        = string
  default     = "subnet11"
}

variable "vm" {
  description = "provide vm name"
  type        = string
  default     = "linux_vm"
}