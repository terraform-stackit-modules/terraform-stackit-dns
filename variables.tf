variable "project_id" {
  description = "STACKIT project ID in which the DNS zones and record sets are created."
  type        = string
}

variable "zones" {
  description = <<-EOT
    Map of DNS zones to create, keyed by a stable identifier (reused as the zone reference key
    by records, so `for_each` never runs over a known-after-apply zone_id). Each value:
      - `name`            (required) : user-given name of the zone.
      - `dns_name`        (required) : the zone DNS name, e.g. `example.com`.
      - `type`                       : `primary` (default) or `secondary`.
      - `contact_email`              : contact e-mail for the zone.
      - `description`                : zone description.
      - `acl`                        : access control list CIDR (currently no enforcement effect).
      - `default_ttl`                : default TTL, e.g. 3600.
      - `expire_time` / `refresh_time` / `retry_time` / `negative_cache` : SOA timings.
      - `is_reverse_zone`            : whether the zone is a reverse zone (default false).
      - `primaries`                  : primary name servers for a secondary zone.
      - `active`                     : whether the zone is active.
  EOT
  type = map(object({
    name            = string
    dns_name        = string
    type            = optional(string)
    contact_email   = optional(string)
    description     = optional(string)
    acl             = optional(string)
    default_ttl     = optional(number)
    expire_time     = optional(number)
    refresh_time    = optional(number)
    retry_time      = optional(number)
    negative_cache  = optional(number)
    is_reverse_zone = optional(bool)
    primaries       = optional(list(string))
    active          = optional(bool)
  }))
  default = {}

  validation {
    condition = alltrue([
      for z in values(var.zones) : z.type == null || contains(["primary", "secondary"], z.type)
    ])
    error_message = "zones[*].type must be either \"primary\" or \"secondary\"."
  }
}

variable "records" {
  description = <<-EOT
    Map of DNS record sets to create, keyed by a stable identifier. Each value:
      - `zone_key` (required) : the key of the zone (in `var.zones`) this record belongs to.
      - `name`     (required) : record name, a valid domain per rfc1035, e.g. `www.example.com`.
      - `type`     (required) : record set type, e.g. `A`, `AAAA`, `CNAME`, `MX`, `TXT`.
      - `records`  (required) : list of record values, e.g. ["1.2.3.4"].
      - `ttl`                 : time to live, e.g. 3600.
      - `comment`             : free-text comment.
      - `active`              : whether the record set is active (default true).
  EOT
  type = map(object({
    zone_key = string
    name     = string
    type     = string
    records  = list(string)
    ttl      = optional(number)
    comment  = optional(string)
    active   = optional(bool)
  }))
  default = {}

  validation {
    condition = alltrue([
      for r in values(var.records) : contains(keys(var.zones), r.zone_key)
    ])
    error_message = "Each records[*].zone_key must reference an existing key in var.zones."
  }
}
