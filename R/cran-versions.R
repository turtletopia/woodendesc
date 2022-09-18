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
  assert_param_package(package)

  cran_versions_cache(package)
}

#' @importFrom versionsort ver_latest
cran_versions_cache <- function(package) {
  cache_file <- cache_path("versions", "CRAN", package)

  # Return usable cache if exists
  if (is_cache_usable(cache_file)) return(readRDS(cache_file))

  # Return "expired" cache if no new version was published in the meantime
  if (file.exists(cache_file)) {
    version_codes <- readRDS(cache_file)
    if (ver_latest(version_codes) == wood_cran_latest(package)) return(version_codes)
  }

  # Download new data and cache it
  url <- crandb_url("-", "allall", params = list(start_key = package, limit = 1))
  desc <- download_safely(url)

  validate_cran_package(package, desc)

  # Extract all cacheable data
  versions <- desc[[package]][["versions"]]
  version_codes <- names(versions)
  latest <- desc[[package]][["latest"]]

  # Save cache
  saveRDS(versions, cache_path("descriptions", "CRAN", package))
  saveRDS(version_codes, cache_file)
  saveRDS(latest, cache_path("latest", "CRAN", package))

  # Return value
  version_codes
}
