resource "stackit_dns_zone" "this" {
  for_each = var.zones

  project_id      = var.project_id
  name            = each.value.name
  dns_name        = each.value.dns_name
  type            = each.value.type
  contact_email   = each.value.contact_email
  description     = each.value.description
  acl             = each.value.acl
  default_ttl     = each.value.default_ttl
  expire_time     = each.value.expire_time
  refresh_time    = each.value.refresh_time
  retry_time      = each.value.retry_time
  negative_cache  = each.value.negative_cache
  is_reverse_zone = each.value.is_reverse_zone
  primaries       = each.value.primaries
  active          = each.value.active
}

resource "stackit_dns_record_set" "this" {
  for_each = var.records

  project_id = var.project_id
  # Reference the zone by its STABLE map key (known at plan time), never the
  # known-after-apply zone_id, so for_each stays valid.
  zone_id = stackit_dns_zone.this[each.value.zone_key].zone_id
  name    = each.value.name
  type    = each.value.type
  records = each.value.records
  ttl     = each.value.ttl
  comment = each.value.comment
  active  = each.value.active
}
