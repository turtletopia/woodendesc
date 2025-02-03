#' List Bioconductor releases
#'
#' @description This function scrapes the Bioconductor site for version codes
#' of all its releases.
#'
#' @return A character vector, where each element is a Bioconductor release.
#'
#' @examples
#' ## Only run with internet access
#' if (interactive()) {
#' wood_bioc_releases()
#' }
#'
#' @family bioc
#' @export
wood_bioc_releases <- function() {
  rlang::check_installed("xml2", "to list Bioconductor release codes.")

  bioc_releases_cache()
}

bioc_releases_cache <- function() {
  with_cache({
    httr2::request("https://bioconductor.org") |>
      httr2::req_url_path_append("about", "release-announcements") |>
      httr2::req_perform() |>
      httr2::resp_body_html(encoding = "UTF-8") |>
      xml2::xml_find_all("/html/body/main//table/tbody/tr/td[1]") |>
      xml2::xml_text()
  }, "releases", "bioc")
}
