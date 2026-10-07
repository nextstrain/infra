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

import {
  to = dnsimple_zone_record.generated_placeholder_name_data_alias_13657496
  id = "nextstrain.org_13657496"
}

resource "dnsimple_zone_record" "generated_placeholder_name_data_alias_13657496" {
  zone_name = "nextstrain.org"
  name      = "data"
  value     = "d2g4c5td1w6cf1.cloudfront.net"
  type      = "ALIAS"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_staging_alias_13657502
  id = "nextstrain.org_13657502"
}

resource "dnsimple_zone_record" "generated_placeholder_name_staging_alias_13657502" {
  zone_name = "nextstrain.org"
  name      = "staging"
  value     = "dfi7kuaykxbmy.cloudfront.net"
  type      = "ALIAS"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_root_mx_14255798
  id = "nextstrain.org_14255798"
}

resource "dnsimple_zone_record" "generated_placeholder_name_root_mx_14255798" {
  zone_name = "nextstrain.org"
  name      = ""
  value     = "in1-smtp.messagingengine.com"
  type      = "MX"
  ttl       = 3600
  priority  = 10
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_root_mx_14255799
  id = "nextstrain.org_14255799"
}

resource "dnsimple_zone_record" "generated_placeholder_name_root_mx_14255799" {
  zone_name = "nextstrain.org"
  name      = ""
  value     = "in2-smtp.messagingengine.com"
  type      = "MX"
  ttl       = 3600
  priority  = 20
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_root_txt_14255800
  id = "nextstrain.org_14255800"
}

resource "dnsimple_zone_record" "generated_placeholder_name_root_txt_14255800" {
  zone_name = "nextstrain.org"
  name      = ""
  value     = "\"v=spf1 include:spf.messagingengine.com include:spf.zoho.com include:transmail.net include:amazonses.com -all\""
  type      = "TXT"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_fm1_domainkey_cname_14255801
  id = "nextstrain.org_14255801"
}

resource "dnsimple_zone_record" "generated_placeholder_name_fm1_domainkey_cname_14255801" {
  zone_name = "nextstrain.org"
  name      = "fm1._domainkey"
  value     = "fm1.nextstrain.org.dkim.fmhosted.com"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_fm2_domainkey_cname_14255802
  id = "nextstrain.org_14255802"
}

resource "dnsimple_zone_record" "generated_placeholder_name_fm2_domainkey_cname_14255802" {
  zone_name = "nextstrain.org"
  name      = "fm2._domainkey"
  value     = "fm2.nextstrain.org.dkim.fmhosted.com"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_fm3_domainkey_cname_14255803
  id = "nextstrain.org_14255803"
}

resource "dnsimple_zone_record" "generated_placeholder_name_fm3_domainkey_cname_14255803" {
  zone_name = "nextstrain.org"
  name      = "fm3._domainkey"
  value     = "fm3.nextstrain.org.dkim.fmhosted.com"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_rethink_cname_14390617
  id = "nextstrain.org_14390617"
}

resource "dnsimple_zone_record" "generated_placeholder_name_rethink_cname_14390617" {
  zone_name = "nextstrain.org"
  name      = "rethink"
  value     = "ec2-52-91-236-36.compute-1.amazonaws.com"
  type      = "CNAME"
  ttl       = 600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_ed0fe6fff5ac0e3fb44cef4b50e1add9_login_cname_16622358
  id = "nextstrain.org_16622358"
}

resource "dnsimple_zone_record" "generated_placeholder_name_ed0fe6fff5ac0e3fb44cef4b50e1add9_login_cname_16622358" {
  zone_name = "nextstrain.org"
  name      = "_ed0fe6fff5ac0e3fb44cef4b50e1add9.login"
  value     = "_7506948dc145406b3b3e34a4700c2f1c.olprtlswtu.acm-validations.aws"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_login_alias_16622441
  id = "nextstrain.org_16622441"
}

resource "dnsimple_zone_record" "generated_placeholder_name_login_alias_16622441" {
  zone_name = "nextstrain.org"
  name      = "login"
  value     = "d31vnikn6y38x3.cloudfront.net"
  type      = "ALIAS"
  ttl       = 600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_root_txt_17522362
  id = "nextstrain.org_17522362"
}

resource "dnsimple_zone_record" "generated_placeholder_name_root_txt_17522362" {
  zone_name = "nextstrain.org"
  name      = ""
  value     = "\"google-site-verification=MKfOapfIvt4U2tExw9vc3xCZGB_-Hvq4TYd8NVZDOmg\""
  type      = "TXT"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_b07442bc64501c40e30f1c518f82fb74_data_cname_17562120
  id = "nextstrain.org_17562120"
}

resource "dnsimple_zone_record" "generated_placeholder_name_b07442bc64501c40e30f1c518f82fb74_data_cname_17562120" {
  zone_name = "nextstrain.org"
  name      = "_b07442bc64501c40e30f1c518f82fb74.data"
  value     = "_2e8e4ea703a5c39694e52e41e30a8158.vhzmpjdqfx.acm-validations.aws"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_record_338bec46521564c66f600f460cee08bd_staging_cname_17562125
  id = "nextstrain.org_17562125"
}

resource "dnsimple_zone_record" "generated_placeholder_name_record_338bec46521564c66f600f460cee08bd_staging_cname_17562125" {
  zone_name = "nextstrain.org"
  name      = "_338bec46521564c66f600f460cee08bd.staging"
  value     = "_172a3dd2f6ff5a9bf29fef7cc1cb3d0f.vhzmpjdqfx.acm-validations.aws"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_discussion_cname_18384869
  id = "nextstrain.org_18384869"
}

resource "dnsimple_zone_record" "generated_placeholder_name_discussion_cname_18384869" {
  zone_name = "nextstrain.org"
  name      = "discussion"
  value     = "nextstrain.hosted-by-discourse.com"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_docs_cname_18534719
  id = "nextstrain.org_18534719"
}

resource "dnsimple_zone_record" "generated_placeholder_name_docs_cname_18534719" {
  zone_name = "nextstrain.org"
  name      = "docs"
  value     = "readthedocs.io"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_dfdafbd41aee2901b38b80b2ff9d72e8_clades_cname_18889622
  id = "nextstrain.org_18889622"
}

resource "dnsimple_zone_record" "generated_placeholder_name_dfdafbd41aee2901b38b80b2ff9d72e8_clades_cname_18889622" {
  zone_name = "nextstrain.org"
  name      = "_dfdafbd41aee2901b38b80b2ff9d72e8.clades"
  value     = "_dad53b4907a86a69b254f21bb2d6a03e.tfmgdnztqk.acm-validations.aws"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_clades_alias_18889636
  id = "nextstrain.org_18889636"
}

resource "dnsimple_zone_record" "generated_placeholder_name_clades_alias_18889636" {
  zone_name = "nextstrain.org"
  name      = "clades"
  value     = "d1g6t68q9jcn2y.cloudfront.net"
  type      = "ALIAS"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_staging_clades_alias_18889638
  id = "nextstrain.org_18889638"
}

resource "dnsimple_zone_record" "generated_placeholder_name_staging_clades_alias_18889638" {
  zone_name = "nextstrain.org"
  name      = "staging.clades"
  value     = "d2s32idavvrb32.cloudfront.net"
  type      = "ALIAS"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_master_clades_alias_18889642
  id = "nextstrain.org_18889642"
}

resource "dnsimple_zone_record" "generated_placeholder_name_master_clades_alias_18889642" {
  zone_name = "nextstrain.org"
  name      = "master.clades"
  value     = "d2a2pa72juuhp4.cloudfront.net"
  type      = "ALIAS"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_data_master_clades_cname_25530118
  id = "nextstrain.org_25530118"
}

resource "dnsimple_zone_record" "generated_placeholder_name_data_master_clades_cname_25530118" {
  zone_name = "nextstrain.org"
  name      = "data.master.clades"
  value     = "d1zi0i0kio1q0m.cloudfront.net"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_data_staging_clades_cname_25530121
  id = "nextstrain.org_25530121"
}

resource "dnsimple_zone_record" "generated_placeholder_name_data_staging_clades_cname_25530121" {
  zone_name = "nextstrain.org"
  name      = "data.staging.clades"
  value     = "d3blhic35wy19j.cloudfront.net"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_data_clades_cname_25530130
  id = "nextstrain.org_25530130"
}

resource "dnsimple_zone_record" "generated_placeholder_name_data_clades_cname_25530130" {
  zone_name = "nextstrain.org"
  name      = "data.clades"
  value     = "dn44topf2ltnq.cloudfront.net"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_record_58e141b04bf154c57feb28124fb9595f_data_staging_clades_cname_25531277
  id = "nextstrain.org_25531277"
}

resource "dnsimple_zone_record" "generated_placeholder_name_record_58e141b04bf154c57feb28124fb9595f_data_staging_clades_cname_25531277" {
  zone_name = "nextstrain.org"
  name      = "_58e141b04bf154c57feb28124fb9595f.data.staging.clades"
  value     = "_7c4f4abee543673f622cc61d1701da92.gxwgcdsjsl.acm-validations.aws"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_bb46d1070dd5a524e9e55a2a1431c1ba_master_clades_cname_25531283
  id = "nextstrain.org_25531283"
}

resource "dnsimple_zone_record" "generated_placeholder_name_bb46d1070dd5a524e9e55a2a1431c1ba_master_clades_cname_25531283" {
  zone_name = "nextstrain.org"
  name      = "_bb46d1070dd5a524e9e55a2a1431c1ba.master.clades"
  value     = "_9926029d8159aac321d13025c9b51e72.gxwgcdsjsl.acm-validations.aws"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_d3859e41eb0d0c88d9fb4fa7fd3cf49f_data_master_clades_cname_25531292
  id = "nextstrain.org_25531292"
}

resource "dnsimple_zone_record" "generated_placeholder_name_d3859e41eb0d0c88d9fb4fa7fd3cf49f_data_master_clades_cname_25531292" {
  zone_name = "nextstrain.org"
  name      = "_d3859e41eb0d0c88d9fb4fa7fd3cf49f.data.master.clades"
  value     = "_3972f4d17b40b893d93f378eca87fc76.gxwgcdsjsl.acm-validations.aws"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_record_8bff34ae3394b010e6467c14ae1fe050_data_clades_cname_25531301
  id = "nextstrain.org_25531301"
}

resource "dnsimple_zone_record" "generated_placeholder_name_record_8bff34ae3394b010e6467c14ae1fe050_data_clades_cname_25531301" {
  zone_name = "nextstrain.org"
  name      = "_8bff34ae3394b010e6467c14ae1fe050.data.clades"
  value     = "_540bca1b00fef96a423b1e3c2c3d4ae3.gxwgcdsjsl.acm-validations.aws"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_e849e6e105a9e2913def27346bf03bbb_staging_clades_cname_25531306
  id = "nextstrain.org_25531306"
}

resource "dnsimple_zone_record" "generated_placeholder_name_e849e6e105a9e2913def27346bf03bbb_staging_clades_cname_25531306" {
  zone_name = "nextstrain.org"
  name      = "_e849e6e105a9e2913def27346bf03bbb.staging.clades"
  value     = "_7c6fd5c4e0778a2d6cf5271c3a124c63.gxwgcdsjsl.acm-validations.aws"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_support_cname_26356978
  id = "nextstrain.org_26356978"
}

resource "dnsimple_zone_record" "generated_placeholder_name_support_cname_26356978" {
  zone_name = "nextstrain.org"
  name      = "support"
  value     = "desk.cs.zohohost.com"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_zdab846d66abf3eb39500c3176eb28214b_cname_26356981
  id = "nextstrain.org_26356981"
}

resource "dnsimple_zone_record" "generated_placeholder_name_zdab846d66abf3eb39500c3176eb28214b_cname_26356981" {
  zone_name = "nextstrain.org"
  name      = "zdab846d66abf3eb39500c3176eb28214b"
  value     = "desk.cs.zohohost.com"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_root_txt_26383756
  id = "nextstrain.org_26383756"
}

resource "dnsimple_zone_record" "generated_placeholder_name_root_txt_26383756" {
  zone_name = "nextstrain.org"
  name      = ""
  value     = "\"google-site-verification=Xkfn_pf5ryuQGElxu6kU_0P457nPp64lg7X5P0wUZ44\""
  type      = "TXT"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_buirnqtis_domainkey_txt_27063459
  id = "nextstrain.org_27063459"
}

resource "dnsimple_zone_record" "generated_placeholder_name_buirnqtis_domainkey_txt_27063459" {
  zone_name = "nextstrain.org"
  name      = "buirnqtis._domainkey"
  value     = "\"v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDJBoHH6z1Zfawnx5PRrgwPyh/jwH31Wc3cADskS9ldRBJAjp3mEfM3AuFRtl+rZxedhlDyCWeeIIPFEs98zWLxlD2m3BIqY0EtPiz1QuYRR+rH0HERO5a98cFGiSXM7bv29gOsxMwBDjeYVZDYpNpUdv6O1prGb3ibyBVJ3yQfpwIDAQAB\""
  type      = "TXT"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_record_1522905413783_domainkey_txt_27063461
  id = "nextstrain.org_27063461"
}

resource "dnsimple_zone_record" "generated_placeholder_name_record_1522905413783_domainkey_txt_27063461" {
  zone_name = "nextstrain.org"
  name      = "1522905413783._domainkey"
  value     = "\"k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCr6KMgdxxgg7oT3ulMwPJs9RXgXDrI9UWU118pHEMohl3UbL3Jwp4oxp/9N3thh/3WCJnYV134zbEVolZwqaT3JsFEq/mQ/RpW/JnOZ3rnxqJPurb2bcfJol4SDxiWVObzHX31xnANzFcXnq1/5dMK5QvW4Jh7n0fm4+4ywqiy2QIDAQAB\""
  type      = "TXT"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_wiki_cname_28641261
  id = "nextstrain.org_28641261"
}

resource "dnsimple_zone_record" "generated_placeholder_name_wiki_cname_28641261" {
  zone_name = "nextstrain.org"
  name      = "wiki"
  value     = "descriptive-potatoe-0qb2umtd52yng273pe3paa4j.herokudns.com"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_next_cname_30811012
  id = "nextstrain.org_30811012"
}

resource "dnsimple_zone_record" "generated_placeholder_name_next_cname_30811012" {
  zone_name = "nextstrain.org"
  name      = "next"
  value     = "floating-roundworm-p7nhz1eykxesl69armtppfme.herokudns.com"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_sr5mgl4s4ktksa45i4zzmsyiz6fg2eam_domainkey_cname_35715869
  id = "nextstrain.org_35715869"
}

resource "dnsimple_zone_record" "generated_placeholder_name_sr5mgl4s4ktksa45i4zzmsyiz6fg2eam_domainkey_cname_35715869" {
  zone_name = "nextstrain.org"
  name      = "sr5mgl4s4ktksa45i4zzmsyiz6fg2eam._domainkey"
  value     = "sr5mgl4s4ktksa45i4zzmsyiz6fg2eam.dkim.amazonses.com"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_wi6evc5xcco6rfl526x7ngzptgy4g7f6_domainkey_cname_35715875
  id = "nextstrain.org_35715875"
}

resource "dnsimple_zone_record" "generated_placeholder_name_wi6evc5xcco6rfl526x7ngzptgy4g7f6_domainkey_cname_35715875" {
  zone_name = "nextstrain.org"
  name      = "wi6evc5xcco6rfl526x7ngzptgy4g7f6._domainkey"
  value     = "wi6evc5xcco6rfl526x7ngzptgy4g7f6.dkim.amazonses.com"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_record_7nmbk7n6e6guzenqkbl2ojlv7cwcxgcz_domainkey_cname_35715888
  id = "nextstrain.org_35715888"
}

resource "dnsimple_zone_record" "generated_placeholder_name_record_7nmbk7n6e6guzenqkbl2ojlv7cwcxgcz_domainkey_cname_35715888" {
  zone_name = "nextstrain.org"
  name      = "7nmbk7n6e6guzenqkbl2ojlv7cwcxgcz._domainkey"
  value     = "7nmbk7n6e6guzenqkbl2ojlv7cwcxgcz.dkim.amazonses.com"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_amazon_ses_mx_35715891
  id = "nextstrain.org_35715891"
}

resource "dnsimple_zone_record" "generated_placeholder_name_amazon_ses_mx_35715891" {
  zone_name = "nextstrain.org"
  name      = "amazon-ses"
  value     = "feedback-smtp.us-east-1.amazonses.com"
  type      = "MX"
  ttl       = 3600
  priority  = 10
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_amazon_ses_txt_35715892
  id = "nextstrain.org_35715892"
}

resource "dnsimple_zone_record" "generated_placeholder_name_amazon_ses_txt_35715892" {
  zone_name = "nextstrain.org"
  name      = "amazon-ses"
  value     = "\"v=spf1 include:amazonses.com -all\""
  type      = "TXT"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_dmarc_txt_35716160
  id = "nextstrain.org_35716160"
}

resource "dnsimple_zone_record" "generated_placeholder_name_dmarc_txt_35716160" {
  zone_name = "nextstrain.org"
  name      = "_dmarc"
  value     = "\"v=DMARC1; p=reject; sp=quarantine; adkim=r; aspf=r; pct=100; rua=mailto:re+avwkkc5zq5z@dmarc.postmarkapp.com; ruf=mailto:admin@nextstrain.org\""
  type      = "TXT"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_root_txt_42535045
  id = "nextstrain.org_42535045"
}

resource "dnsimple_zone_record" "generated_placeholder_name_root_txt_42535045" {
  zone_name = "nextstrain.org"
  name      = ""
  value     = "\"google-site-verification=5d_PLzfcFSRO1TQ5T4v1WdEGS2xf9T_7Gk9AQXsYeRI\""
  type      = "TXT"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_v2_clades_cname_48078605
  id = "nextstrain.org_48078605"
}

resource "dnsimple_zone_record" "generated_placeholder_name_v2_clades_cname_48078605" {
  zone_name = "nextstrain.org"
  name      = "v2.clades"
  value     = "d96gn25so5l34.cloudfront.net"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_status_cname_60429632
  id = "nextstrain.org_60429632"
}

resource "dnsimple_zone_record" "generated_placeholder_name_status_cname_60429632" {
  zone_name = "nextstrain.org"
  name      = "status"
  value     = "nextstrain.github.io"
  type      = "CNAME"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_github_pages_challenge_nextstrain_status_txt_60429645
  id = "nextstrain.org_60429645"
}

resource "dnsimple_zone_record" "generated_placeholder_name_github_pages_challenge_nextstrain_status_txt_60429645" {
  zone_name = "nextstrain.org"
  name      = "_github-pages-challenge-nextstrain.status"
  value     = "\"1cbe42ec82d9b5db3de58b1dfac65f\""
  type      = "TXT"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_atproto_txt_60701992
  id = "nextstrain.org_60701992"
}

resource "dnsimple_zone_record" "generated_placeholder_name_atproto_txt_60701992" {
  zone_name = "nextstrain.org"
  name      = "_atproto"
  value     = "\"did=did:plc:ohkww2nholgvn6wg7wd7lftj\""
  type      = "TXT"
  ttl       = 3600
}

import {
  to = dnsimple_zone_record.generated_placeholder_name_discussion_test_url_78264011
  id = "nextstrain.org_78264011"
}

resource "dnsimple_zone_record" "generated_placeholder_name_discussion_test_url_78264011" {
  zone_name = "nextstrain.org"
  name      = "discussion-test"
  value     = "https://discussion.nextstrain.org"
  type      = "URL"
  ttl       = 3600
}
