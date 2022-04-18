#' @export
wood_url_version <- function(package, repository) {
  url_PACKAGES_cache(repository)[[package]][["Version"]]
}
