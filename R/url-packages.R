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
  assert_param_url_repo(repository)

  packages <- vapply(
    url_PACKAGES_cache(repository), `[[`, character(1), "Package"
  )
  unique(packages)
}

#' @importFrom digest digest
url_PACKAGES_cache <- function(repository) {
  repository <- remove_trailing_slash(repository)

  with_cache({
    download_repo_data(paste(repository, "src", "contrib", sep = "/"))
  }, "PACKAGES", digest(repository))
}
