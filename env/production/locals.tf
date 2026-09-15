locals {
  # By design our repo names are usually equal to the pathogen names, but
  # they're two separate things/namespaces and linkages don't always line up
  # 1:1.  Some resources (roles, policies, etc) are more naturally oriented
  # per-pathogen (logical), some per-repo (physical).  Use two maps to support
  # this more easily.  This will likely evolve in the future to better support
  # our needs.
  #   -trs, 20 May 2024

  # These are pathogen repos that are using pathogen-repo-build. There are other
  # pathogen repos that have not been automated yet that are not included here.
  pathogen_repos = tomap({
    # pathogen name   = [repo name, …]
    "avian-flu"       = ["avian-flu"],
    "dengue"          = ["dengue"],
    "chikv"           = ["chikv"],
    "ebola"           = ["ebola"],
    "forecasts-flu"   = ["forecasts-flu"],
    "forecasts-ncov"  = ["forecasts-ncov"],
    "hantavirus"      = ["hantavirus"],
    "hmpv"            = ["hmpv"],
    "lassa"           = ["lassa"],
    "measles"         = ["measles"],
    "mumps"           = ["mumps"],
    "mpox"            = ["mpox"],
    "ncov"            = ["ncov", "ncov-ingest"],
    "nipah"           = ["nipah"],
    "norovirus"       = ["norovirus"],
    "oropouche"       = ["oropouche"],
    "rabies"          = ["rabies"],
    "rsv"             = ["rsv"],
    "rubella"         = ["rubella"],
    "seasonal-cov"    = ["seasonal-cov"],
    "seasonal-flu"    = ["seasonal-flu", "forecasts-flu", "avian-flu"],
    "tb"              = ["tb"],
    "WNV"             = ["WNV"],
    "yellow-fever"    = ["yellow-fever"],
    "zika"            = ["zika"],
  })

  repo_pathogens = merge(
    # repo name = [pathogen name, …]
    transpose(local.pathogen_repos),

    tomap({
      # For testing.  Ensures a role exists but without any pathogen-specific
      # permissions.
      ".github" = [],
    }),
  )

  # Repo ids for OIDC immutable subject claims.¹
  #
  # An entry mapping the repo name to id is required if the "Use immutable
  # subject claim" box is checked on the page:
  #
  #     https://github.com/nextstrain/<repo-name>/settings/actions/oidc-configuration
  #
  # You can get the repo id by running:
  #
  #     gh api repos/nextstrain/<repo-name> --jq .id
  #
  # ¹ https://docs.github.com/en/actions/reference/security/oidc#immutable-subject-claims
  repo_ids = tomap({
    "hantavirus" = "1307765855"
  })
  repo_sub_prefixes = {
    for repo in keys(local.repo_pathogens) :
    repo => (
      # If the repo has an id, use the immutable format.
      contains(keys(local.repo_ids), repo)
      ? "repo:nextstrain@22159334/${repo}@${local.repo_ids[repo]}"

      # Otherwise, use the legacy format.
      : "repo:nextstrain/${repo}"
    )
  }
}
