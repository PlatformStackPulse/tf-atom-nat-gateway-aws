variable "allocation_id" {
  description = "Allocation ID of the Elastic IP (required for public NAT)"
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "ID of the subnet for the NAT gateway"
  type        = string
  validation {
    condition     = length(var.subnet_id) > 0
    error_message = "subnet_id must not be empty."
  }
}

variable "connectivity_type" {
  description = "Connectivity type (public or private)"
  type        = string
  default     = "public"
  validation {
    condition     = contains(["public", "private"], var.connectivity_type)
    error_message = "connectivity_type must be public or private."
  }
}
