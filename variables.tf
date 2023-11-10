#==================#
# Naming & Tagging #
#==================#

variable "environment" {
  description = "A naming object for the environment to provide both the environment's name and abbrevation for tagging and reporting purposes"
  type = object({
    name         = string
    abbreviation = string
  })

  validation {
    condition     = can(regex("^[a-zA-Z 0-9\\-]*$", var.environment.name))
    error_message = "The environment name must only contain alphanumeric characters, spaces, and hyphens"
  }
  validation {
    condition     = can(regex("^[a-z0-9\\-]*$", var.environment.abbreviation))
    error_message = "The environment abbreviation must be kebab case"
  }
}
variable "naming" {
  description = "A naming object to provide the display name of the service from the service catalog, and optionally also a resource name"
  type = object({
    display  = string
    resource = optional(string, null)
  })

  validation {
    condition     = can(regex("^[a-zA-Z 0-9\\-]*$", var.naming.display))
    error_message = "The service display name must only contain alphanumeric characters, spaces, and hyphens"
  }
  validation {
    condition     = can(regex("^[a-z0-9\\-]*$", var.naming.resource)) || var.naming.resource == null
    error_message = "If provided, the service resource name must be kebab case"
  }
}
variable "tagging" {
  description = "A collection of tags as key-value pairs to be applied to all applicable provisioned resources"
  type = object({
    additional_tags = optional(map(any), {})
    network         = string
    organization    = string
    owner           = string
    service_name    = optional(string, null)
    service_pattern = string
    tag_key_prefix  = string
  })
}

#==================#
# Resource Configs #
#==================#

variable "certificate_domain" {
  type        = string
  description = "The domain to be used for the certificate"
}
variable "hosted_zone_domain" {
  type        = string
  description = "The name of the Route53 hosted zone to be used for validation"
}
variable "subject_alternative_names" {
  description = "(Optional) Set of domains that should be SANs in the issued certificate. To remove all elements of a previously configured list, set this value equal to an empty list (`[]`) or use the `terraform taint` command to trigger recreation"
  type        = list(string)
  default     = []
}
