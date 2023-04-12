#' Get dependencies of a package on CRAN
#'
#' @description This function queries CRAN for dependencies of the selected
#' version of a selected package. By default, it queries the latest version.
#'
#' @template package
#' @param version `character(1)`\cr
#'  A version code without leading `"v"`, e.g. `"1.6.0"`.
#'
#' @return A data frame with three columns, all in string format:
#' * `package` (package name),
#' * `version` (minimum version requirement or `NA` if none),
#' * `type` (dependency type, e.g. `"Imports"`).
#'
#' @examples
#' \donttest{
#' wood_cran_dependencies("deepdep")
#' wood_cran_dependencies("ggplot2", version = "3.4.0")
#' }
#'
#' @family cran
#' @family dependencies
#' @export
wood_cran_dependencies <- function(package, version = "latest") {
  assert_param_package(package)
  assert_param_version(version)

  version <- match_version_cran(package, version)

  descs <- cran_descriptions_cache(package)
  # Use cached data if available
  if (!is.null(descs)) {
    desc <- descs[[version]]
    if (!is.null(desc)) {
      return(extract_dependencies(desc, parser = parse_dependencies_crandb))
    }
  }
  # If not, try version-specific cache
  desc <- cran_dependencies_cache(package, version)
  extract_dependencies(desc)
}

cran_descriptions_cache <- function(package) {
  with_cache({}, "descriptions", "CRAN", package)
}

cran_dependencies_cache <- function(package, version) {
  with_cache({
    url <- raw_github_url("cran", package, version, "DESCRIPTION")
    desc <- download_safely(url, on_status = list(
      `404` = function() stopf("Can't find package `%1$s` on CRAN.", package)
    ))
    read_dcf(desc)[[package]]
  }, "dependencies", "CRAN", package, version)
}
