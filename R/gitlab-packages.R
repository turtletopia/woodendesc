#' List available package on a Gitlab account
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
#' if (interactive()) {
#'   wood_gitlab_packages("r-packages")
#'   # The function takes care of differentiating
#'   # between users and groups internally
#'   wood_gitlab_packages("matherion")
#' }
#'
#' @family gitlab
#' @family packages
#' @export
wood_gitlab_packages <- function(user, include_forks = FALSE) {
  assert_param_git_user(user)
  assert_param_include_forks(include_forks)

  repos <- gitlab_packages_cache(user)
  if (!include_forks) {
    repos <- Filter(Negate(is_gitlab_fork), repos)
  }
  repos <- Filter(is_gitlab_R_repo, repos)
  vapply(repos, `[[`, character(1), "path")
}

gitlab_packages_cache <- function(user) {
  with_cache({
    rlang::try_fetch({
      api_path <- if (is_gitlab_user(user)) "users" else "groups"
      httr2::request("https://gitlab.com") |>
        httr2::req_url_path_append("api", "v4", api_path, user, "projects") |>
        httr2::req_url_query(per_page = 100) |>
        httr2::req_perform_iterative(
          next_req = httr2::iterate_with_link_url(rel = "next"),
          # There isn't much point in returning incomplete data
          on_error = "stop"
        ) |>
        httr2::resps_data(httr2::resp_body_json)
    }, httr2_http_429 = function(cnd) {
      abort_gl_rate_limit(cnd)
    }, httr2_http_404 = function(cnd) {
      rlang::abort(
        sprintf("Can't find user or group `%1$s` on GitLab.", user),
        parent = cnd
      )
    })
  }, "repos", "gitlab", user)
}
