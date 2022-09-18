is_github_R_repo <- function(repo) {
  owner <- repo[["owner"]][["login"]]
  name <- repo[["name"]]
  branch <- repo[["default_branch"]]
  ret <- with_cache({
    url <- raw_github_url(owner, name, branch, "DESCRIPTION")
    tryCatch({
      content <- download_safely(url)
      list(exists = TRUE, content = content)
    }, error = function(e) list(exists = FALSE, content = NULL))
  }, "DESCRIPTION", "github", owner, name)
  ret[["exists"]]
}

is_fork <- function(repo) {
  repo[["fork"]]
}
