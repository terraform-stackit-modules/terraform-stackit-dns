output "zone_ids" {
  description = "Map of zone key to created zone ID."
  value       = { for k, z in stackit_dns_zone.this : k => z.zone_id }
}

output "zone_dns_names" {
  description = "Map of zone key to its DNS name."
  value       = { for k, z in stackit_dns_zone.this : k => z.dns_name }
}

output "zone_primary_name_servers" {
  description = "Map of zone key to its primary name server (FQDN)."
  value       = { for k, z in stackit_dns_zone.this : k => z.primary_name_server }
}

output "record_set_ids" {
  description = "Map of record key to created record set ID."
  value       = { for k, r in stackit_dns_record_set.this : k => r.record_set_id }
}

output "record_fqdns" {
  description = "Map of record key to its fully qualified domain name."
  value       = { for k, r in stackit_dns_record_set.this : k => r.fqdn }
}
