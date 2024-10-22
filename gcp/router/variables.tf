variable "name" {
  description = "Name of the router"
  type        = string
}

variable "network" {
  description = "A reference to the network to which this router belongs"
  type        = string
}

variable "project" {
  description = "The project ID to deploy to"
  type        = string
}

variable "region" {
  description = "Region where the router resides"
  type        = string
}

variable "description" {
  description = "An optional description of this resource"
  type        = string
  default     = null
}

variable "bgp" {
  description = "BGP information specific to this router."
  type        = any
  default     = null
}

variable "nats" {
  description = "NATs to deploy on this router."
  type        = any
  default     = []
}
