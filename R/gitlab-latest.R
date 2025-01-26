#' Get current package version on GitLab
#'
#' @description This function queries GitLab for the code of the current package
#' version. This may reference a non-tagged commit; for the analysis of tagged
#' commits only, see [wood_gitlab_versions()].
#'
#' @template package
#' @template git-user
#'
#' @return A character vector of version codes.
#'
#' @examples
#' if (interactive()) {
#'   # Latest version code is returned
#'   wood_gitlab_latest("rock", "r-packages")
#'
#'   # To get the latest *tagged* version code instead, use:
#'   wood_gitlab_versions("rock", "r-packages") |>
#'     versionsort::ver_latest()
#' }
#'
#' @family gitlab
#' @family versions
#' @export
wood_gitlab_latest <- function(package, user) {
  assert_param_package(package)
  assert_param_git_user(user)

  desc <- gitlab_description_cache(package, user, "latest")
  read_dcf_one_value(desc, "Version")
}
