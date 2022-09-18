match_local_paths_args <- function(paths) {
  if (identical(paths, "all")) .libPaths() else paths
}

validate_local_package <- function(package, path) {
  # If none found, Find() returns NULL
  if (is.null(path)) {
    stopf("Can't find package `%1$s` in the specified paths.", package)
  }
}
