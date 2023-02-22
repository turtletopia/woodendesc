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

guess_default_branch <- function(user, package, ...) {
  url <- raw_github_url(user, package)

  # First check if cache with default branch data exists
  branch <- with_cache({}, "repos", "github", user)[[package]][["default_branch"]]

  if (is.null(branch)) {
    branch <- with_cache({}, "repo", "github", user, package)[["default_branch"]]
  }

  # If cache found, download data from that branch
  if (!is.null(branch)) {
    return(download_safely(paste(url, branch, ..., sep = "/")))
  }

  # Try master and main branch names
  try({
    return(download_safely(paste(url, "master", ..., sep = "/")))
  }, silent = TRUE)

  try({
    return(download_safely(paste(url, "main", ..., sep = "/")))
  }, silent = TRUE)

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
