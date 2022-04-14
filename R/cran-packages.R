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

  url <- crandb_url("-", "desc")
  packages <- download_safely(url)

  packages <- names(packages)
  saveRDS(packages, cache_file)
  # Return saved object to save time on reading it
  packages
}
