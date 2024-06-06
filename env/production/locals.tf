locals {
  # By design our repo names are usually equal to the pathogen names, but
  # they're two separate things/namespaces and linkages don't always line up
  # 1:1.  Some resources (roles, policies, etc) are more naturally oriented
  # per-pathogen (logical), some per-repo (physical).  Use two maps to support
  # this more easily.  This will likely evolve in the future to better support
  # our needs.
  #   -trs, 20 May 2024
  #
  # The forecasts-ncov repo is conceptually-speaking maybe best thought of as a
  # forecasts/ directory within the ncov repo, similar to how the ncov-ingest
  # repo is best thought of as an ingest/ directory within the same.¹  Unlike
  # ncov-ingest, however, forecasts-ncov publishes files under its own name,
  # e.g. <s3://nextstrain-data/files/workflows/forecasts-ncov/>, instead of
  # ncov's name.  This is why it appears both as its own "pathogen" and as a
  # repo associated with the "ncov" pathogen.  This situation grants
  # forecasts-ncov more access to ncov than is really necessary—it only really
  # needs <s3://nextstrain-ncov-private/metadata.tsv.zst>—but ah well, the
  # alternatives are more complicated.  This same conceptual-confusion of
  # considering "forecasts-ncov" to be a pathogen means it gets access to write
  # <s3://nextstrain-data/forecasts_ncov….json>, which is also unnecessary.
  #
  # We could choose to address this some day, if the pattern of data-generating
  # repos downstream of pathogen repos proliferates, by conceptually separating
  # the two things.
  #   -trs, 6 June 2024
  #
  # ¹ <https://github.com/nextstrain/private/issues/110#issuecomment-2153402857>

  pathogen_repos = tomap({
    # pathogen name   = [repo name, …]
    "dengue"          = ["dengue"],
    "forecasts-ncov"  = ["forecasts-ncov"],
    "measles"         = ["measles"],
    "mpox"            = ["mpox"],
    "ncov"            = ["ncov", "ncov-ingest", "forecasts-ncov"],
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
