#' @export
wood_url_packages <- function(repository) {
  packages <- vapply(
    url_PACKAGES_cache(repository), `[[`, character(1), "Package"
  )
  unique(packages)
}

#' @importFrom digest digest
url_PACKAGES_cache <- function(repository) {
  cache_file <- cache_path("PACKAGES", digest(repository))
  if (is_cache_usable(cache_file)) return(readRDS(cache_file))

  # TODO: handle case if repository ends with a slash
  url <- paste(repository, "src", "contrib", "PACKAGES.gz", sep = "/")
  dcf_data <- download_dcf(url)
  repo_data <- read_dcf(dcf_data)

  saveRDS(repo_data, cache_file)
  # Return saved object to save time on reading it
  repo_data
}
