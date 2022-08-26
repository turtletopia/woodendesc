#' @export
wood_github_packages <- function(user) {
  # TODO: allow excluding forks
  github_packages_cache(user)
}

github_packages_cache <- function(user) {
  with_cache({
    # TODO: add pagination
    url <- github_url("users", user, "repos")
    content <- download_safely(url)
    repos <- vapply(content, `[[`, character(1), "name")
    Filter(function(repo) is_github_R_repo(user, repo), repos)
  }, "packages", "github", user)
}

is_github_R_repo <- function(owner, repo) {
  with_cache({
    url <- github_url("repos", owner, repo, "contents", "DESCRIPTION")
    tryCatch({
      content <- download_safely(url)

      all(c("name", "type") %in% names(content)) &&
        identical(content[["name"]], "DESCRIPTION") &&
        identical(content[["type"]], "file")
    }, error = function(e) FALSE)
  }, "isrepo", "github", owner, repo)
}
