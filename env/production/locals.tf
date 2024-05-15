locals {
  # By design our repo names are usually equal to the pathogen names, but
  # they're two separate things/namespaces and linkages don't always line up
  # 1:1.  Some resources (roles, policies, etc) are more naturally oriented
  # per-pathogen (logical), some per-repo (physical).  Use two maps to support
  # this more easily.  This will likely evolve in the future to better support
  # our needs.
  #   -trs, 20 May 2024

  pathogen_repos = tomap({
    # pathogen name   = [repo name, …]
    "dengue"          = ["dengue"],
    "forecasts-ncov"  = ["forecasts-ncov"],
    "measles"         = ["measles"],
    "mpox"            = ["mpox"],
    "ncov"            = ["ncov", "ncov-ingest"],
    "rsv"             = ["rsv"],
    "seasonal-flu"    = ["seasonal-flu"],
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
}
