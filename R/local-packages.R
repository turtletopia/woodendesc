#' List locally available packages
#'
#' @description This function searches for installed packages inside specified
#' library paths.
#'
#' @param paths \[\code{character()}\]\cr
#'  Paths to local libraries, by default the first element of `.libPaths()`. If
#'  equal to `"all"`, uses all elements of `.libPaths()`.
#'
#' @return A character vector of available packages.
#'
#' @examples
#' \donttest{
#' wood_local_packages()
#' wood_local_packages("all")
#' }
#'
#' @family local
#' @family packages
#' @export
wood_local_packages <- function(paths = .libPaths()[1]) {
  if (length(paths) == 1 && paths == "all")
    paths <- .libPaths()
  unique(list.dirs(paths, full.names = FALSE, recursive = FALSE))
}
