#' List available packages in Bioconductor
#'
#' @description This function queries Bioconductor for a list of available
#' packages. Current and previous releases can be queried, up to
#' Bioconductor 1.5.
#'
#' @template bioc-release
#'
#' @return A character vector of available packages.
#'
#' @examples
#' \donttest{
#' head(wood_bioc_packages())
#' # is the same as
#' head(wood_bioc_packages("release"))
#'
#' # A glimpse in the future:
#' head(wood_bioc_packages("devel"))
#' # Previous versions can be queried as well:
#' head(wood_bioc_packages("3.9"))
#' # The oldest available version is 1.5:
#' wood_bioc_packages("1.5")
#' }
#'
#' @family bioc
#' @family packages
#' @export
wood_bioc_packages <- function(release = "release") {
  assert_param_bioc_release(release)

  packages <- vapply(
    bioc_PACKAGES_cache(release), `[[`, character(1), "Package"
  )
  unique(packages)
}

bioc_PACKAGES_cache <- function(release = "release") {
  with_cache({
    download_repo_data(bioc_release_url(
      release = release, "src", "contrib"
    ))
  }, "PACKAGES", "bioc", release)
}
