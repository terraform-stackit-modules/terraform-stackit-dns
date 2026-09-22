output "zone_ids" {
  description = "Map of zone key to created zone ID."
  value       = module.dns.zone_ids
}

output "record_set_ids" {
  description = "Map of record key to created record set ID."
  value       = module.dns.record_set_ids
}

output "record_fqdns" {
  description = "Map of record key to its FQDN."
  value       = module.dns.record_fqdns
}
