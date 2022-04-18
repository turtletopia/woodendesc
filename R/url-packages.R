#' List available packages in any repository
#'
#' @description This function queries any online repository for a list of
#' available packages. They are returned as a vector of strings, each element
#' being a package name. The data is retrieved from `/src/contrib/PACKAGES`
#' file.
#'
#' @param repository \[\code{character(1)}\]\cr
#'  URL to repository, e.g. `"http://www.omegahat.net/R"`.
#'
#' @return A character vector of available packages.
#'
#' @examples
#' \donttest{
#' wood_url_packages("http://www.omegahat.net/R")
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
  cache_file <- cache_path("PACKAGES", digest(repository))
  if (is_cache_usable(cache_file)) return(readRDS(cache_file))

  repository <- remove_trailing_slash(repository)

  if (R_older_than("4.0.0")) {
    # Don't use gzipped PACKAGES file
    url <- paste(repository, "src", "contrib", "PACKAGES", sep = "/")
    dcf_data <- download_dcf(url, compression = "none")
  } else {
    url <- paste(repository, "src", "contrib", "PACKAGES.gz", sep = "/")
    dcf_data <- download_dcf(url)
  }
  repo_data <- read_dcf(dcf_data)

  saveRDS(repo_data, cache_file)
  # Return saved object to save time on reading it
  repo_data
}
