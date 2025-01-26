#' Get dependencies of a package on GitHub
#'
#' @description This function queries GitHub for dependencies of the selected
#' tagged commit of a repo. By default, it queries the latest commit instead.
#'
#' @template package
#' @template git-user
#' @param tag `character(1)`\cr
#'  Tag of a commit on GitHub or `"latest"` for the latest (possibly untagged)
#'  commit.
#'
#' @return A data frame with three columns, all in string format:
#' * `package` (package name),
#' * `version` (minimum version requirement or `NA` if none),
#' * `type` (dependency type, e.g. `"Imports"`).
#'
#' @examplesIf !woodendesc:::is_cran_check()
#' wood_github_dependencies("gglgbtq", "turtletopia")
#' wood_github_dependencies("versionsort", "turtletopia", tag = "v1.0.0")
#'
#' @family github
#' @family dependencies
#' @export
wood_github_dependencies <- function(package, user, tag = "latest") {
  assert_param_package(package)
  assert_param_git_user(user)
  assert_param_tag(tag)

  desc <- github_description_cache(package, user, tag)
  desc <- read_dcf(desc)[[package]]
  extract_dependencies(desc)
}

github_description_cache <- function(package, user, tag) {
  if (tag == "latest") {
    ret <- with_cache({
      content <- guess_default_branch_gh(user, package, "DESCRIPTION") |>
        httr2::resp_body_string()
      list(exists = TRUE, content = content)
    }, "DESCRIPTION", "github", user, package)
    ret[["content"]]
  } else {
    with_cache({
      rlang::try_fetch({
        httr2::request("https://raw.githubusercontent.com") |>
          httr2::req_url_path_append(user, package, tag, "DESCRIPTION") |>
          httr2::req_perform() |>
          httr2::resp_body_string()
      }, httr2_http_403 = function(cnd) {
        abort_gh_rate_limit(cnd)
      }, httr2_http_404 = function(cnd) {
        rlang::abort(
          c(sprintf("Can't find DESCRIPTION file in `%1$s/%2$s` repository on Github.", user, package),
            "i" = sprintf("Is `%1$s` a valid tag?", tag)),
          parent = cnd
        )
      })
    }, "DESCRIPTION", "github", user, package, tag)
  }
}
