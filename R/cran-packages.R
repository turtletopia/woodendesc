#' List available packages on CRAN
#'
#' @description This function queries CRAN for a list of available packages.
#' They are returned as a vector of strings, each element being a package name.
#'
#' @return A character vector of available packages.
#'
#' @examples
#' \donttest{
#' wood_cran_packages()
#' }
#'
#' @family cran
#' @family packages
#' @export
wood_cran_packages <- function() {
  cran_packages_cache()
}

cran_packages_cache <- function() {
  cache_file <- cache_path("packages", "cran")
  if (is_cache_usable(cache_file)) return(readRDS(cache_file))

  url <- cran_url("src", "contrib", "PACKAGES.gz")

  if (R_older_than("4.0.0")) {
    # memDecompress handles gzip since R 4.0.0
    raw_response <- download_safely(url, as = "raw")
    file <- tempfile()
    writeBin(raw_response, file)
    packages <- read.dcf(file)[, "Package"]

    unlink(file)
  } else {
    packages_dcf <- download_dcf(url)
    packages <- read_dcf_all_values(packages_dcf, "Package")
  }

  saveRDS(packages, cache_file)
  # Return saved object to save time on reading it
  packages
}
