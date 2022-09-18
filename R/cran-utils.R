match_version_cran <- function(package, version) {
  if (version == "latest") wood_cran_latest(package) else version
}

validate_cran_package <- function(package, desc) {
  if (is.null(desc[[package]])) {
    stopf("Can't find package `%1$s` on CRAN.", package)
  }
}
