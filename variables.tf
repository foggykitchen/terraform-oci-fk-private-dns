variable "compartment_ocid" {
  description = "Compartment OCID where the private DNS resources will be created."
  type        = string
}

variable "name" {
  description = "Base name used for private DNS resources."
  type        = string
}

variable "vcn_id" {
  description = "VCN OCID used to discover the VCN-associated private resolver when resolver_id is not provided."
  type        = string
}

variable "resolver_id" {
  description = "Optional private resolver OCID to update directly. When null, the module discovers the resolver from vcn_id."
  type        = string
  default     = null
}

variable "attach_managed_views_to_resolver" {
  description = "Whether to attach the managed views to the VCN-associated private resolver."
  type        = bool
  default     = true
}

variable "extra_attached_view_ids" {
  description = "Additional private view IDs to keep attached when managing the resolver."
  type        = list(string)
  default     = []
}

variable "views" {
  description = "Map of private DNS views to create."
  type = map(object({
    display_name = optional(string)
  }))
  default = {}
}

variable "zones" {
  description = "Map of private DNS zones and optional RRsets to create."
  type = map(object({
    name     = string
    view_key = optional(string)
    view_id  = optional(string)
    rrsets = optional(map(object({
      domain = string
      rtype  = string
      ttl    = number
      items = list(object({
        rdata = string
        ttl   = optional(number)
      }))
    })), {})
  }))
  default = {}

  validation {
    condition = alltrue([
      for zone in values(var.zones) : try(zone.view_key, null) != null || try(zone.view_id, null) != null
    ])
    error_message = "Each zone must define either view_key or view_id."
  }
}

variable "defined_tags" {
  description = "Defined tags applied to top-level resources created by the module."
  type        = map(string)
  default     = {}
}

variable "freeform_tags" {
  description = "Freeform tags applied to top-level resources created by the module."
  type        = map(string)
  default     = {}
}
