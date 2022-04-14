#' Get all package versions on CRAN
#'
#' @description This function queries CRAN for the codes of all available
#' package versions, both current and archived, for a given package.
#'
#' @template package
#'
#' @return A character vector of version codes.
#'
#' @examples
#' \donttest{
#' wood_cran_versions("versionsort")
#' }
#'
#' @family cran
#' @family versions
#' @export
wood_cran_versions <- function(package) {
  cran_versions_cache(package)
}

#' @importFrom versionsort ver_latest
cran_versions_cache <- function(package) {
  cache_file <- cache_path("versions", "CRAN", package)

  # Return usable cache if exists
  if (is_cache_usable(cache_file)) return(readRDS(cache_file))

  # Return "expired" cache if no new version was published in the meantime
  if (file.exists(cache_file)) {
    versions <- readRDS(cache_file)
    if (ver_latest(versions) == wood_cran_latest(package)) return(versions)
  }

  # Download new data and cache it
  url <- cran_url("-", "allall", params = list(start_key = package, limit = 1))
  desc <- download_safely(url)
  versions <- names(desc[[package]][["versions"]])

  saveRDS(versions, cache_file)
  versions
}
