#' @export
wood_local_packages <- function(path = .libPaths()[1]) {
  list.dirs(path, full.names = FALSE, recursive = FALSE)
}
