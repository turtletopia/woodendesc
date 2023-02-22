#' List available package on a Github account
#'
#' @description This function finds packages among repositories belonging to a
#' selected account. They are returned as a vector of strings, each element
#' being a repository (and in most cases, package) name.
#'
#' @template gh-user
#' @param include_forks `logical(1)`\cr
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
  assert_param_gh_user(user)
  assert_param_include_forks(include_forks)

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
    paginate(url, on_status = list(
      `403` = stopf_gh_rate_limit,
      `404` = function() stopf("Can't find user `%1$s` on GitHub.", user)
    ))
  }, "repos", "github", user)
}
