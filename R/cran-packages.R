#' @export
wood_cran_packages <- function() {
  cran_packages_cache()
}

cran_packages_cache <- function() {
  cache_file <- cache_path("packages", "cran")
  if (is_cache_usable(cache_file)) return(readRDS(cache_file))

  url <- cran_url("-", "desc")
  packages <- download_safely(url)

  packages <- names(packages)
  saveRDS(packages, cache_file)
  # Return saved object to save time on reading it
  packages
}
