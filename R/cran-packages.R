#' List available packages on CRAN
#'
#' @description This function queries CRAN for a list of available packages.
#' They are returned as a vector of strings, each element being a package name.
#'
#' @return A character vector of available packages.
#'
#' @examplesIf !woodendesc:::is_cran_check()
#' print(wood_cran_packages(), max = 15)
#'
#' @family cran
#' @family packages
#' @export
wood_cran_packages <- function() {
  cran_packages_cache()
}

cran_packages_cache <- function() {
  with_cache({
    packages_dcf <- httr2::request("https://CRAN.R-project.org") |>
      httr2::req_url_path_append("src", "contrib", "PACKAGES.gz") |>
      httr2::req_perform() |>
      httr2::resp_body_raw() |>
      memDecompress(type = "gzip", asChar = TRUE) |>
      read_dcf_all_values("Package")
  }, "packages", "cran")
}
