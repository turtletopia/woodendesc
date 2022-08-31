#' Get latest package version on CRAN
#'
#' @description This function queries CRAN for the code of the latest version
#' of the selected package.
#'
#' @template package
#'
#' @return A single string with a version code.
#'
#' @examples
#' \donttest{
#' wood_cran_latest("versionsort")
#' }
#'
#' @family cran
#' @family versions
#' @export
wood_cran_latest <- function(package) {
  assert_param_package(package)

  cran_latest_cache(package)
}

cran_latest_cache <- function(package) {
  with_cache({
    url <- crandb_url("-", "desc", params = list(start_key = package, limit = 1))
    desc <- download_safely(url)
    validate_cran_package(package, desc)

    desc[[package]][["version"]]
  }, "latest", "CRAN", package)
}
