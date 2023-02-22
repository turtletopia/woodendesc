#' Get dependencies of a core R package
#'
#' @description This function collects the dependencies of the selected core R
#' package.
#'
#' @template package
#'
#' @return A data frame with three columns, all in string format:
#' * `package` (package name),
#' * `version` (minimum version requirement or `NA` if none),
#' * `type` (dependency type, e.g. `"Imports"`).
#'
#' @examples
#' wood_core_dependencies("tcltk")
#'
#' @family core
#' @family dependencies
#' @importFrom utils installed.packages
#' @export
wood_core_dependencies <- function(package) {
  assert_param_package(package)

  core_pkgs <- installed.packages(priority = "base")
  validate_core_package(package, core_pkgs)

  extract_dependencies(core_pkgs[package, ])
}
