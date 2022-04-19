#' @export
wood_local_versions <- function(package, paths = .libPaths()[1]) {
  paths <- match_local_paths_args(paths)
  # Filter paths that contain package DESCRIPTION
  descriptions <- file.path(paths, package, "DESCRIPTION")
  descriptions <- descriptions[file.exists(descriptions)]
  # Extract package version from each DESCRIPTION found
  ret <- vapply(descriptions, function(desc) {
    read_description_version(readChar(desc, nchar = file.info(desc)[["size"]]))
  }, character(1), USE.NAMES = FALSE)
  # Return only unique values
  unique(ret)
}
