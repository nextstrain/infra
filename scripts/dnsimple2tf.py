#!/usr/bin/env python3
"""
Generate Terraform import and resource blocks for DNSimple zone.
"""

from __future__ import annotations

import json
import os
import re
import sys
import urllib.error
import urllib.request
from dataclasses import dataclass
from typing import Optional

ACCOUNT_ID = "79981"


@dataclass
class DnsRecord:
    name: str
    type: str
    value: str
    ttl: int
    priority: Optional[int] = None
    record_id: Optional[str] = None


def main() -> None:
    if len(sys.argv) < 2:
        sys.exit(f"Usage: {sys.argv[0]} <zone_name>")

    zone_name = sys.argv[1].rstrip(".")

    # Require DNSIMPLE_TOKEN to fetch records
    token = os.environ.get("DNSIMPLE_TOKEN")
    if not token:
        sys.exit("Error: DNSIMPLE_TOKEN environment variable is not set.")

    api_records = fetch_dnsimple_records(
        account_id=ACCOUNT_ID,
        zone_name=zone_name,
        token=token,
    )

    records: list[DnsRecord] = []
    for item in api_records:
        # Skip read-only/system records (e.g. SOA and apex NS)
        if item.get("system_record") or item.get("type") in ("SOA", "NS"):
            continue

        rec = DnsRecord(
            name=item["name"],
            type=item["type"],
            value=item["content"],
            ttl=item["ttl"],
            priority=item.get("priority"),
            record_id=str(item["id"]),
        )
        records.append(rec)

        display_name = rec.name or "@"
        print(f"Processing record: {rec.type:<5} {display_name} (ID: {rec.record_id})", file=sys.stderr)

    # Generate Terraform HCL blocks
    output_hcl = generate_tf_output(
        records=records,
        zone_name=zone_name,
    )

    sys.stdout.write(output_hcl)


def fetch_dnsimple_records(account_id: str, zone_name: str, token: str) -> list[dict]:
    records: list[dict] = []
    page = 1
    per_page = 100
    while True:
        url = f"https://api.dnsimple.com/v2/{account_id}/zones/{zone_name}/records?page={page}&per_page={per_page}"
        data = query_dnsimple_api(url, token)
        page_records = data.get("data", [])
        records.extend(page_records)
        pagination = data.get("pagination", {})
        current_page = pagination.get("current_page", page)
        total_pages = pagination.get("total_pages", 1)
        if current_page >= total_pages or not page_records:
            break
        page += 1
    return records


def query_dnsimple_api(url: str, token: str) -> dict:
    req = urllib.request.Request(
        url,
        headers={
            "Authorization": f"Bearer {token}",
            "Accept": "application/json",
            "User-Agent": "nextstrain/infra (https://nextstrain.org)",
        },
    )
    try:
        with urllib.request.urlopen(req) as resp:
            return json.loads(resp.read().decode("utf-8"))
    except urllib.error.HTTPError as err:
        body = err.read().decode("utf-8", errors="replace")
        raise RuntimeError(f"HTTP {err.code} {err.reason}: {body}") from err


def generate_tf_output(
    records: list[DnsRecord],
    zone_name: str,
) -> str:
    blocks: list[str] = []

    for rec in records:
        res_name = generate_resource_name(rec)

        block = format_import_and_resource_block(
            zone_name=zone_name,
            resource_name=res_name,
            record=rec,
        )
        blocks.append(block)

    return "\n\n".join(blocks) + ("\n" if blocks else "")


def generate_resource_name(rec: DnsRecord) -> str:
    name_part = sanitize_identifier(rec.name) if rec.name else "root"
    type_part = rec.type.lower()
    return f"generated_placeholder_name_{name_part}_{type_part}_{rec.record_id}"


def sanitize_identifier(name: str) -> str:
    sanitized = re.sub(r"[^a-zA-Z0-9_]", "_", name)
    sanitized = re.sub(r"_+", "_", sanitized).strip("_")
    if sanitized and sanitized[0].isdigit():
        sanitized = f"record_{sanitized}"
    return sanitized


def format_import_and_resource_block(
    zone_name: str,
    resource_name: str,
    record: DnsRecord,
) -> str:
    import_id = f"{zone_name}_{record.record_id}"

    lines = [
        "import {",
        f"  to = dnsimple_zone_record.{resource_name}",
        f'  id = "{import_id}"',
        "}",
        "",
        f'resource "dnsimple_zone_record" "{resource_name}" {{',
        f'  zone_name = "{zone_name}"',
        f'  name      = "{record.name}"',
        f'  value     = "{escape_hcl_string(record.value)}"',
        f'  type      = "{record.type}"',
        f"  ttl       = {record.ttl}",
    ]
    if record.priority is not None:
        lines.append(f"  priority  = {record.priority}")
    lines.append("}")

    return "\n".join(lines)


def escape_hcl_string(s: str) -> str:
    return s.replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n")


if __name__ == "__main__":
    main()
