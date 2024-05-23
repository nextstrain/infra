resource "github_repository_topics" "nextstrain" {
  for_each = toset(flatten(values(local.pathogen_repos)))
  repository = each.key
  topics = ["nextstrain", "pathogen"]
}
