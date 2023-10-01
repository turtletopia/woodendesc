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

guess_default_branch_gh <- function(user, package, ...) {
  ret <- guess_default_branch("github", user, package, ...)

  if (!is.null(ret)) {
    return(ret)
  }

  # If failed, download data with default branch name
  repo_data <- with_cache({
    url_repos <- github_url("repos", user, package)
    download_safely(url_repos, on_status = list(
      `403` = stopf_gh_rate_limit,
      `404` = function() stopf(
        "Can't find repository `%1$s/%2$s` on Github.", user, package
      )
    ))
  }, "repo", "github", user, package)
  branch <- repo_data[["default_branch"]]

  download_safely(paste(url, branch, ..., sep = "/"))
}
