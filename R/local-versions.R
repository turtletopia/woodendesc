#' Get locally available package versions
#'
#' @description This function searches for installed package versions inside
#' specified library paths.
#'
#' @template package
#' @template paths-local
#'
#' @return A character vector of version codes.
#'
#' @examples
#' \donttest{
#' wood_local_versions("httr")
#' }
#'
#' @family local
#' @family versions
#' @export
wood_local_versions <- function(package, paths = .libPaths()[1]) {
  paths <- match_local_paths_args(paths)
  # Filter paths that contain package DESCRIPTION
  descriptions <- file.path(paths, package, "DESCRIPTION")
  descriptions <- descriptions[file.exists(descriptions)]
  # Extract package version from each DESCRIPTION found
  ret <- vapply(descriptions, function(desc) {
    read_dcf_one_value(readChar(desc, nchar = file.info(desc)[["size"]]), "Version")
  }, character(1), USE.NAMES = FALSE)
  # Return only unique values
  unique(ret)
}