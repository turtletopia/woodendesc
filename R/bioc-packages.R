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
#' ## Only run with internet access
#' if (interactive()) {
#' print(wood_bioc_packages(), max = 15)
#' # is the same as
#' print(wood_bioc_packages("release"), max = 15)
#' }
#'
#' if (interactive()) {
#' # A glimpse in the future:
#' print(wood_bioc_packages("devel"), max = 15)
#' }
#'
#' if (interactive()) {
#' # Previous versions can be queried as well:
#' print(wood_bioc_packages("3.9"), max = 15)
#' }
#'
#' if (interactive()) {
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
