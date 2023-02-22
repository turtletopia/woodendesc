#' Get dependencies of a package on GitHub
#'
#' @description This function queries GitHub for dependencies of the selected
#' tagged commit of a repo. By default, it queries the latest commit instead.
#'
#' @template package
#' @template gh-user
#' @param tag `character(1)`\cr
#'  Tag of a commit on GitHub or `"latest"` for the latest (possibly untagged)
#'  commit.
#'
#' @return A data frame with three columns, all in string format:
#' * `package` (package name),
#' * `version` (minimum version requirement or `NA` if none),
#' * `type` (dependency type, e.g. `"Imports"`).
#'
#' @examples
#' \donttest{
#' wood_github_dependencies("gglgbtq", "turtletopia")
#' wood_github_dependencies("versionsort", "turtletopia", tag = "v1.0.0")
#' }
#'
#' @family github
#' @family dependencies
#' @export
wood_github_dependencies <- function(package, user, tag = "latest") {
  assert_param_package(package)
  assert_param_gh_user(user)
  assert_param_tag(tag)

  desc <- github_description_cache(package, user, tag)
  desc <- read_dcf(desc)[[package]]
  extract_dependencies(desc)
}

github_description_cache <- function(package, user, tag) {
  if (tag == "latest") {
    ret <- with_cache({
      content <- guess_default_branch(user, package, "DESCRIPTION")
      list(exists = TRUE, content = content)
    }, "DESCRIPTION", "github", user, package)
    ret[["content"]]
  } else {
    with_cache({
      url <- raw_github_url(user, package, tag, "DESCRIPTION")
      content <- download_safely(url, on_status = list(
        `403` = stopf_gh_rate_limit,
        `404` = function() stopf(c(
          "Can't find DESCRIPTION file in `%1$s/%2$s` repository on Github.\n",
          "(i) Is `%3$s` a valid tag?"
        ), user, package, tag)
      ))
    }, "DESCRIPTION", "github", user, package, tag)
  }
}
