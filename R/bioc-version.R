#' Get available package version in Bioconductor
#'
#' @description This function queries Bioconductor for the code of the available
#' version of the selected package for given Bioconductor release.
#'
#' @template package
#' @template bioc-release
#'
#' @return A single string with a version code.
#'
#' @examples
#' ## Only run with internet access
#' if (interactive()) {
#' wood_bioc_version("Biostrings")
#' }
#'
#' if (interactive()) {
#' # What's coming next?
#' wood_bioc_version("Biostrings", release = "devel")
#' }
#'
#' if (interactive()) {
#' # Can query releases as old as 1.8:
#' wood_bioc_version("Biostrings", release = "1.8")
#' }
#'
#' @family bioc
#' @family versions
#' @export
wood_bioc_version <- function(package, release = "release") {
  assert_param_package(package)
  assert_param_bioc_release(release)
  validate_bioc_release(release)

  desc <- bioc_PACKAGES_cache(release)[[package]]

  validate_bioc_package(desc, package, release)

  desc[["Version"]]
}
