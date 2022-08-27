#' @export
wood_github_packages <- function(user, include_forks = FALSE) {
  github_packages_cache(user, include_forks)
}

github_packages_cache <- function(user, include_forks = FALSE) {
  with_cache({
    url <- github_url("users", user, "repos")
    repos <- paginate(url)
    if (!include_forks) {
      repos <- Filter(Negate(is_fork), repos)
    }
    repos <- Filter(is_github_R_repo, repos)
    vapply(repos, `[[`, character(1), "name")
  }, "repos", "github", user)
}

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
