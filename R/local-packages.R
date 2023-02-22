#' List locally available packages
#'
#' @description This function searches for installed packages inside specified
#' library paths.
#'
#' @template paths-local
#'
#' @return A character vector of available packages.
#'
#' @examples
#' wood_local_packages()
#' wood_local_packages("all")
#'
#' @family local
#' @family packages
#' @export
wood_local_packages <- function(paths = .libPaths()[1]) {
  assert_param_paths(paths)

  paths <- match_local_paths_args(paths)
  unique(list.dirs(paths, full.names = FALSE, recursive = FALSE))
}
