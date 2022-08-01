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
#' \donttest{
#' wood_core_dependencies("tcltk")
#' }
#'
#' @family core
#' @family dependencies
#' @export
wood_core_dependencies <- function(package) {
  core_pkgs <- installed.packages(priority = "base")

  if (!package %in% rownames(core_pkgs))
    stop("package not part of R core", call. = FALSE)

  extract_dependencies(core_pkgs[package, ])
}
