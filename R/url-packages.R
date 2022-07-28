#' List available packages in any repository
#'
#' @description This function queries any online repository for a list of
#' available packages. They are returned as a vector of strings, each element
#' being a package name. The data is retrieved from `/src/contrib/PACKAGES`
#' or `/src/contrib/PACKAGES.gz` file.
#'
#' @template repository
#'
#' @return A character vector of available packages.
#'
#' @examples
#' \donttest{
#' wood_url_packages("http://www.omegahat.net/R")
#' # Trailing slashes are removed
#' wood_url_packages("http://www.omegahat.net/R/")
#' }
#'
#' @family url
#' @family packages
#' @export
wood_url_packages <- function(repository) {
  packages <- vapply(
    url_PACKAGES_cache(repository), `[[`, character(1), "Package"
  )
  unique(packages)
}

#' @importFrom digest digest
url_PACKAGES_cache <- function(repository) {
  repository <- remove_trailing_slash(repository)

  cache_file <- cache_path("PACKAGES", digest(repository))
  if (is_cache_usable(cache_file)) return(readRDS(cache_file))

  dcf_data <- NULL
  if (getRversion() >= "4.0.0") {
    # PACKAGES.gz may be unavailable sometimes
    url <- paste(repository, "src", "contrib", "PACKAGES.gz", sep = "/")
    try({
      dcf_data <- download_dcf(url)
    }, silent = TRUE)
  }
  if (is.null(dcf_data)) {
    # Use non-gzipped PACKAGES file
    url <- paste(repository, "src", "contrib", "PACKAGES", sep = "/")
    dcf_data <- download_dcf(url, compression = "none")
  }
  repo_data <- read_dcf(dcf_data)

  saveRDS(repo_data, cache_file)
  # Return saved object to save time on reading it
  repo_data
}
