#' List Bioconductor releases
#'
#' @description This function scrapes the Bioconductor site for version codes
#' of all its releases.
#'
#' @return A character vector, where each element is a Bioconductor release.
#'
#' @examples
#' \donttest{
#' wood_bioc_releases()
#' }
#'
#' @family bioc
#' @export
wood_bioc_releases <- function() {
  if (!require_packages("xml2", "list Bioconductor release codes")) {
    stopf("xml2 package is required to list Bioconductor release codes.")
  }

  bioc_releases_cache()
}

bioc_releases_cache <- function() {
  with_cache({
    response <- download_safely(
      add_trailing_slash(bioc_url("about", "release-announcements")),
      encoding = "UTF-8"
    )
    extract_bioc_releases(response)
  }, "releases", "bioc")
}
