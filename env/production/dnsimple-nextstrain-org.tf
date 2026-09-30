# DNS records for nextstrain.org.
# This file may be incomplete. Full list:
# <https://app.dnsimple.com/a/79981/domains/nextstrain.org/records>

import {
  to = dnsimple_zone_record.dev
  id = "nextstrain.org_13906961"
}

resource "dnsimple_zone_record" "dev" {
  zone_name = "nextstrain.org"
  name      = "dev"
  value     = "triangular-cantaloupe-7os9ny6f1oy00vw3apdgjn58.herokudns.com"
  type      = "ALIAS"
  ttl       = 3600
}
