variable "nodes" {
  description = "Metadata of the virtual machines to be created."
  type        = any
}

variable "hpcc" {
  description = "HPCC build metadata."
  type        = any
}

variable "network" {
  description = "VNET metadata"
  type = any
}

variable "metadata" {
  description = "Project metadata"
  type        = any
}

variable "keypair" {
  description = "Security settings"
  type        = any
}

variable "users" {
  description = "Authorized users' credentials"
  type = any
  sensitive = false
}
