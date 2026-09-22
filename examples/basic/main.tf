#####################################################################################
# Terraform module examples are meant to show an _example_ on how to use a module
# per use-case. The code below should not be copied directly but referenced in order
# to build your own root module that invokes this module.
#
# This example is self-contained and requires only `project_id`: it creates a
# primary DNS zone and an A record set in that zone.
#####################################################################################

module "dns" {
  source = "../.."

  project_id = var.project_id

  zones = {
    example = {
      name          = "example-zone"
      dns_name      = var.dns_name
      type          = "primary"
      contact_email = "hostmaster@example.com"
      default_ttl   = 3600
      description   = "Example zone managed by terraform-stackit-dns"
    }
  }

  records = {
    www = {
      zone_key = "example"
      name     = "www.${var.dns_name}"
      type     = "A"
      records  = ["192.0.2.10"]
      ttl      = 300
      comment  = "Example A record"
    }
  }
}
