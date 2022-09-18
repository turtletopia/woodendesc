#' Get current package version in any repository
#'
#' @description This function queries any online repository for the code of the
#' current version of the selected package.
#'
#' @template package
#' @template repository
#'
#' @return A single string with a version code.
#'
#' @examples
#' \donttest{
#' wood_url_version("XML", repository = "http://www.omegahat.net/R")
#' }
#'
#' @family url
#' @family versions
#' @export
wood_url_version <- function(package, repository) {
  assert_param_package(package)
  assert_param_url_repo(repository)

  desc <- url_PACKAGES_cache(repository)[[package]]

  validate_package_url(desc, package, repository)

  desc[["Version"]]
}
