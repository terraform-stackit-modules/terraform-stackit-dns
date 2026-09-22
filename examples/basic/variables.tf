variable "project_id" {
  description = "The STACKIT project ID."
  type        = string
}

variable "dns_name" {
  description = "The DNS name (domain) of the zone created by the example."
  type        = string
  default     = "example-terraform-stackit.com"
}
