# DNS records for nextstrain.org.
# This file may be incomplete. Full list:
# <https://app.dnsimple.com/a/79981/domains/nextstrain.org/records>

resource "dnsimple_zone_record" "root" {
  zone_name = "nextstrain.org"
  name      = ""
  value     = "192.124.249.28"
  type      = "A"
  ttl       = 3600
}

resource "dnsimple_zone_record" "root_expedited_waf_validation" {
  zone_name = "nextstrain.org"
  name      = "_B68C69A875E9B02689F2EE3287BAABDD"
  value     = "CFEA5C8692E35547B4E76AFCF9C8521E.EDA78261B47DA24F27968A80D3005470.rYSx0gfAt7X98ipg66mW.sectigo.com"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.www
  id = "nextstrain.org_13657444"
}

resource "dnsimple_zone_record" "www" {
  zone_name = "nextstrain.org"
  name      = "www"
  value     = "www.nextstrain.org.herokudns.com"
  type      = "CNAME"
  ttl       = 3600
}

resource "dnsimple_zone_record" "dev" {
  zone_name = "nextstrain.org"
  name      = "dev"
  value     = "triangular-cantaloupe-7os9ny6f1oy00vw3apdgjn58.herokudns.com"
  type      = "ALIAS"
  ttl       = 3600
}
