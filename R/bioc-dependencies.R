#' Get dependencies of a package in Bioconductor
#'
#' @description This function queries Bioconductor for dependencies of the
#' selected package for given Bioconductor release.
#'
#' @template package
#' @template bioc-release
#'
#' @return A data frame with three columns, all in string format:
#' * `package` (package name),
#' * `version` (minimum version requirement or `NA` if none),
#' * `type` (dependency type, e.g. `"Imports"`).
#'
#' @examplesIf !woodendesc:::is_cran_check()
#' wood_bioc_dependencies("Biostrings")
#'
#' # Will dependencies change?
#' wood_bioc_dependencies("Biostrings", "devel")
#' # And what about dependencies in the past?
#' wood_bioc_dependencies("Biostrings", "2.10")
#' wood_bioc_dependencies("Biostrings", "1.8")
#'
#' @family bioc
#' @family dependencies
#' @export
wood_bioc_dependencies <- function(package, release = "release") {
  assert_param_package(package)
  assert_param_bioc_release(release)
  validate_bioc_release(release)

  desc <- bioc_PACKAGES_cache(release)[[package]]

  validate_bioc_package(desc, package, release)

  extract_dependencies(desc)
}
