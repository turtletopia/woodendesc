#' List locally available packages
#'
#' @description This function searches for installed packages inside a specified
#' library path.
#'
#' @param path \[\code{character(1)}\]\cr
#'  A path to local library, by default the first in `.libPaths()`.
#'
#' @return A character vector of available packages.
#'
#' @examples
#' \donttest{
#' wood_local_packages()
#' }
#'
#' @family local
#' @family packages
#' @export
wood_local_packages <- function(path = .libPaths()[1]) {
  unique(list.dirs(path, full.names = FALSE, recursive = FALSE))
}
