#' List available packages on CRAN
#'
#' @description This function queries CRAN for a list of available packages.
#' They are returned as a vector of strings, each element being a package name.
#'
#' @return A character vector of available packages.
#'
#' @examples
#' \donttest{
#' head(wood_cran_packages())
#' }
#'
#' @family cran
#' @family packages
#' @export
wood_cran_packages <- function() {
  cran_packages_cache()
}

cran_packages_cache <- function() {
  with_cache({
    url <- cran_url("src", "contrib", "PACKAGES.gz")

    if (getRversion() >= "4.0.0") {
      packages_dcf <- download_dcf(url)
      packages <- read_dcf_all_values(packages_dcf, "Package")
    } else {
      # memDecompress handles gzip since R 4.0.0
      raw_response <- download_safely(url, as = "raw")
      file <- tempfile()
      writeBin(raw_response, file)
      packages <- read.dcf(file)[, "Package"]

      unlink(file)
    }

    packages
  }, "packages", "cran")
}
