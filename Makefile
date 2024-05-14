SHELL := bash -euo pipefail

lockfiles := $(shell git ls-files '**/.terraform.lock.hcl')

## Re-generate Terraform provider lock files for all expected platforms.
lockfiles: $(lockfiles)
$(lockfiles): %/.terraform.lock.hcl: PHONY
	terraform -chdir=$* providers lock -platform={linux_amd64,darwin_{amd64,arm64}}

## Print this help message.
help:
	@perl -ne 'print if /^## / ... s/^(?<!##)(.+?):.*/make \1\n/ and not /^#( |$$)/' Makefile

.PHONY: PHONY help
PHONY:
