#' List available package on a Github account
#'
#' @description This function finds packages among repositories belonging to a
#' selected account. They are returned as a vector of strings, each element
#' being a repository (and in most cases, package) name.
#'
#' @param user \code{character(1)}\cr
#'  Name of a user or organization.
#' @param include_forks \code{logical(1)}\cr
#'  Whether to include packages forked from other accounts.
#'
#' @return A character vector of available packages.
#'
#' @examples
#' \donttest{
#' wood_github_packages("turtletopia")
#' # I moved most my packages to turtletopia
#' wood_github_packages("ErdaradunGaztea", include_forks = TRUE)
#' }
#'
#' @family github
#' @family packages
#' @export
wood_github_packages <- function(user, include_forks = FALSE) {
  repos <- github_packages_cache(user)
  if (!include_forks) {
    repos <- Filter(Negate(is_fork), repos)
  }
  repos <- Filter(is_github_R_repo, repos)
  vapply(repos, `[[`, character(1), "name")
}

github_packages_cache <- function(user) {
  with_cache({
    url <- github_url("users", user, "repos")
    paginate(url)
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
