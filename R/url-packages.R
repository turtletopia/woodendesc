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
#' ## Only run with internet access
#' if (interactive()) {
#' wood_url_packages("https://colinfay.me")
#' # Trailing slashes are removed
#' wood_url_packages("https://colinfay.me/")
#' }
#'
#' @family url
#' @family packages
#' @export
wood_url_packages <- function(repository) {
  assert_param_url_repo(repository)

  url_PACKAGES_cache(repository) |>
    vapply(function(x) { x[["Package"]] }, character(1)) |>
    unique()
}

url_PACKAGES_cache <- function(repository) {
  # TODO: should we allow setting a different URL path?
  req <- httr2::request(repository) |>
    httr2::req_url_path_append("src", "contrib")

  # Note that we can't hash() `repository` because it may contain trailing slash which doesn't affect actual URL
  with_cache({
    download_repo_data(req)
  }, "PACKAGES", rlang::hash(req))
}
