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

resource "dnsimple_zone_record" "dev_expedited_waf_validation" {
  zone_name = "nextstrain.org"
  name      = "_8609FFB48587DFCDD98BE67C6EAF52B2.dev"
  value     = "01483969DA09BBE5E9F26E48B371A139.2C963701248834FFE7CB1AA9F76807AA.ccDTdcPx7K7RW2uDDyHD.sectigo.com"
  type      = "CNAME"
  ttl       = 3600
}
