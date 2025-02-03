#' Get current package version on GitHub
#'
#' @description This function queries GitHub for the code of the current package
#' version. This may reference a non-tagged commit; for the analysis of tagged
#' commits only, see [wood_github_versions()].
#'
#' @template package
#' @template git-user
#'
#' @return A character vector of version codes.
#'
#' @examples
#' ## Only run with internet access
#' if (interactive()) {
#' # Latest version code is returned
#' wood_github_latest("gglgbtq", "turtletopia")
#' }
#'
#' if (interactive()) {
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
  assert_param_git_user(user)

  desc <- github_description_cache(package, user, "latest")
  read_dcf_one_value(desc, "Version")
}
