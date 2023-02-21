#' Get current package version on GitHub
#'
#' @description This function queries GitHub for the code of the current package
#' versions. This may reference a non-tagged commit; for the analysis of tagged
#' commits only, see [wood_github_versions()].
#'
#' @template package
#' @template gh-user
#'
#' @return A character vector of version codes.
#'
#' @examples
#' \dontrun{
#' # Latest version code is returned
#' wood_github_latest("gglgbtq", "turtletopia")
#'
#' # To get the latest *tagged* version code instead, use:
#' codes <- wood_github_versions("gglgbtq", "turtletopia")
#' versionsort::ver_latest(codes)
#' }
#'
#' @family github
#' @family versions
#' @export
wood_github_latest <- function(package, user) {
  assert_param_package(package)
  assert_param_gh_user(user)

  github_latest_cache(package, user)
}

github_latest_cache <- function(package, user) {
  ret <- with_cache({
    guess_default_branch(user, package, "DESCRIPTION")
  }, "DESCRIPTION", "github", user, package)
  read_dcf_one_value(ret, "Version")
}
