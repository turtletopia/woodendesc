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
#' \donttest{
#' wood_bioc_version("Biostrings")
#'
#' # What's coming next?
#' wood_bioc_version("Biostrings", release = "devel")
#' # Can query releases as old as 1.5:
#' wood_bioc_version("Biostrings", release = "1.5")
#' }
#'
#' @family bioc
#' @family versions
#' @export
wood_bioc_version <- function(package, release = "release") {
  assert_param_package(package)
  assert_param_bioc_release(release)

  desc <- bioc_PACKAGES_cache(release)[[package]]

  if (is.null(desc)) {
    stopf(
      "Can't find package `%1$s` in Bioconductor release `%2$s`.",
      package, release
    )
  }

  desc[["Version"]]
}
