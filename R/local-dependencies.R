#' Get dependencies of locally available package
#'
#' @description This function extracts dependencies of the selected package,
#' searching through specified library paths.
#'
#' @template package
#' @template paths-local
#'
#' @return A data frame with three columns, all in string format:
#' * `package` (package name),
#' * `version` (minimum version requirement or `NA` if none),
#' * `type` (dependency type, e.g. `"Imports"`).
#'
#' @examples
#' wood_local_dependencies("woodendesc")
#' wood_local_dependencies("httr", paths = "all")
#'
#' @family local
#' @family dependencies
#' @export
wood_local_dependencies <- function(package, paths = .libPaths()[1]) {
  assert_param_package(package)
  assert_param_paths(paths)

  paths <- match_local_paths_args(paths)
  # Find first path for which DESCRIPTION exists
  desc_path <- Find(
    file.exists, file.path(paths, package, "DESCRIPTION")
  )

  validate_local_package(package, desc_path)

  desc <- read_dcf(read_char(desc_path))[[package]]
  extract_dependencies(desc)
}
