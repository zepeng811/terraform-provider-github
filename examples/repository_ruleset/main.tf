resource "github_repository" "example_repo" {
  name        = "example-repository"
  description = "Example repository"
}

resource "github_repository_ruleset" "example_ruleset" {
  name        = "example ruleset"
  repository  = github_repository.example_repo.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["refs/heads/main", "refs/heads/master"]
      exclude = ["refs/heads/dev*"]
    }
  }

  rules {
    creation                = true
    update                  = true
    deletion                = true
    required_linear_history = true
    required_signatures     = true

    merge_queue {
      min_entries_to_merge_wait_minutes = 33
    }
  }
}
