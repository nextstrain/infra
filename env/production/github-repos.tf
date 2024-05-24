data "github_repository" "pathogen" {
  for_each = toset(flatten(values(local.pathogen_repos)))
  name = each.key
}

resource "github_repository_topics" "pathogen" {
  for_each = data.github_repository.pathogen
  repository = each.key
  topics = toset(flatten([each.value.topics, "nextstrain", "pathogen"]))
}
