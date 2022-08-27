#' @export
wood_github_packages <- function(user) {
  # TODO: allow excluding forks
  github_packages_cache(user)
}

github_packages_cache <- function(user) {
  with_cache({
    url <- github_url("users", user, "repos")
    content <- paginate(url)
    repos <- Filter(is_github_R_repo, content)
    vapply(repos, `[[`, character(1), "name")
  }, "repos", "github", user)
}

is_github_R_repo <- function(repo) {
  owner <- repo[["owner"]][["login"]]
  name <- repo[["name"]]
  branch <- repo[["default_branch"]]
  # TODO: save both the content and the existence of DESCRIPTION
  with_cache({
    url <- raw_github_url(owner, name, branch, "DESCRIPTION")
    tryCatch({
      content <- download_safely(url)
      TRUE
    }, error = function(e) FALSE)
  }, "isrepo", "github", owner, name)
}
