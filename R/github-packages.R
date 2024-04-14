#' List available package on a Github account
#'
#' @description This function finds packages among repositories belonging to a
#' selected account. They are returned as a vector of strings, each element
#' being a repository (and in most cases, package) name.
#'
#' @template git-user
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
  assert_param_git_user(user)
  assert_param_include_forks(include_forks)

  repos <- github_packages_cache(user)
  if (!include_forks) {
    repos <- Filter(Negate(is_github_fork), repos)
  }
  repos <- Filter(is_github_R_repo, repos)
  vapply(repos, `[[`, character(1), "name")
}

github_packages_cache <- function(user) {
  with_cache({
    rlang::try_fetch({
      httr2::request("https://api.github.com") |>
        httr2::req_url_path_append("users", user, "repos") |>
        httr2::req_url_query(per_page = 100) |>
        httr2::req_perform_iterative(
          next_req = httr2::iterate_with_link_url(rel = "next"),
          # There isn't much point in returning incomplete data
          on_error = "stop"
        ) |>
        httr2::resps_data(httr2::resp_body_json)
    }, httr2_http_403 = function(cnd) {
      abort_gh_rate_limit(cnd)
    }, httr2_http_404 = function(cnd) {
      rlang::abort(
        sprintf("Can't find user `%1$s` on GitHub.", user),
        parent = cnd
      )
    })
  }, "repos", "github", user)
}
