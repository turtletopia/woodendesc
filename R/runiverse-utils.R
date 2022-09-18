validate_runiverse_description <- function(desc, package, universe) {
  if (length(desc) == 0) {
    stopf("Can't find package `%1$s` in universe `%2$s`.", package, universe)
  }
}
