#' @export
wood_cran_latest <- function(package) {
  cran_latest_cache(package)
}

cran_latest_cache <- function(package) {
  cache_file <- cache_path("latest", "CRAN", package)

  if (is_cache_usable(cache_file)) return(readRDS(cache_file))

  url <- cran_url("-", "desc", params = list(start_key = package, limit = 1))
  desc <- download_safely(url)
  version <- desc[[package]][["version"]]

  saveRDS(version, cache_file)
  version
}
