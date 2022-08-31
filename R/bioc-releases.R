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
    msg <- "xml2 package is required to list Bioconductor release codes."
    stop(msg, call. = FALSE)
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

extract_bioc_releases <- function(html) {
  html <- as.character(html)

  # Two-step extraction due to gregexec being available only since R 4.1.0
  codes <- regmatches(
    html,
    gregexpr("<tr>\\s*<td.*?>\\d+\\.\\d+", html, perl = TRUE)
  )[[1]]
  regmatches(
    codes,
    regexpr("\\d+\\.\\d+", codes, perl = TRUE)
  )
}
