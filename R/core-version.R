#' Get current version of a core R package
#'
#' @description This function checks the version of the selected core R package.
#'
#' @template package
#'
#' @return A single string with a version code. Should be equal to the R version
#' ([base::getRversion()]).
#'
#' @examples
#' wood_core_version("graphics")
#'
#' @family core
#' @family versions
#' @importFrom utils installed.packages
#' @export
wood_core_version <- function(package) {
  assert_param_package(package)

  core_pkgs <- installed.packages(priority = "base")
  validate_core_package(package, core_pkgs)

  core_pkgs[package, "Version"]
}
