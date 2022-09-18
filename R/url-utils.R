validate_package_url <- function(desc, package, repository) {
  if (is.null(desc)) {
    stopf("Can't find package `%1$s` on repository %2$s.", package, repository)
  }
}
