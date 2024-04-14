#' Get dependencies of a package on GitLab
#'
#' @description This function queries GitLab for dependencies of the selected
#' tagged commit of a repo. By default, it queries the latest commit instead.
#'
#' @template package
#' @template git-user
#' @param tag `character(1)`\cr
#'  Tag of a commit on GitLab or `"latest"` for the latest (possibly untagged)
#'  commit.
#'
#' @return A data frame with three columns, all in string format:
#' * `package` (package name),
#' * `version` (minimum version requirement or `NA` if none),
#' * `type` (dependency type, e.g. `"Imports"`).
#'
#' @examples
#' \donttest{
#' wood_gitlab_dependencies("limonaid", "r-packages")
#' wood_gitlab_dependencies("rock", "r-packages", tag = "0.6.3")
#' }
#'
#' @family gitlab
#' @family dependencies
#' @export
wood_gitlab_dependencies <- function(package, user, tag = "latest") {
  assert_param_package(package)
  assert_param_git_user(user)
  assert_param_tag(tag)

  desc <- gitlab_description_cache(package, user, tag)
  desc <- read_dcf(desc)[[package]]
  extract_dependencies(desc)
}

gitlab_description_cache <- function(package, user, tag) {
  if (tag == "latest") {
    ret <- with_cache({
      content <- guess_default_branch_gl(user, package, "DESCRIPTION") |>
        httr2::resp_body_string()
      list(exists = TRUE, content = content)
    }, "DESCRIPTION", "gitlab", user, package)
    ret[["content"]]
  } else {
    with_cache({
      rlang::try_fetch({
        httr2::request("https://gitlab.com") |>
          httr2::req_url_path_append(user, package, "-", "raw", tag, "DESCRIPTION") |>
          httr2::req_perform() |>
          httr2::resp_body_string()
      }, httr2_http_429 = function(cnd) {
        abort_gl_rate_limit(cnd)
      }, httr2_http_404 = function(cnd) {
        rlang::abort(
          c(sprintf("Can't find DESCRIPTION file in `%1$s/%2$s` repository on Gitlab.", user, package),
            "i" = sprintf("Is `%1$s` a valid tag?", tag)),
          parent = cnd
        )
      })
    }, "DESCRIPTION", "gitlab", user, package, tag)
  }
}
