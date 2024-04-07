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
#' # The oldest available version is 1.8:
#' wood_bioc_packages("1.8")
#' }
#'
#' @family bioc
#' @family packages
#' @export
wood_bioc_packages <- function(release = "release") {
  assert_param_bioc_release(release)
  validate_bioc_release(release)

  bioc_PACKAGES_cache(release = release) |>
    vapply(function(x) { x[["Package"]] }, character(1)) |>
    unique()
}

bioc_PACKAGES_cache <- function(release = "release") {
  with_cache({
    httr2::request("https://bioconductor.org") |>
      httr2::req_url_path_append("packages", release, "bioc", "src", "contrib") |>
      download_repo_data()
  }, "PACKAGES", "bioc", release)
}
