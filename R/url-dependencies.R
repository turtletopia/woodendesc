#' Get dependencies of a package in any repository
#'
#' @description This function queries any online repository for dependencies of
#' the selected package.
#'
#' @template package
#' @template repository
#'
#' @return A data frame with three columns, all in string format:
#' * `package` (package name),
#' * `version` (minimum version requirement or `NA` if none),
#' * `type` (dependency type, e.g. `"Imports"`).
#'
#' @examples
#' ## Only run with internet access
#' if (interactive()) {
#' wood_url_dependencies("tidystringdist", repository = "https://colinfay.me")
#' }
#'
#' @family url
#' @family dependencies
#' @export
wood_url_dependencies <- function(package, repository) {
  assert_param_package(package)
  assert_param_url_repo(repository)

  desc <- url_PACKAGES_cache(repository)[[package]]

  validate_package_url(desc, package, repository)

  extract_dependencies(desc)
}
