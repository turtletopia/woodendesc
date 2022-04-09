#' Clear cache
#'
#' @description Remove all \pkg{woodendesc}-related cached files.
#'
#' @return An integer code, invisibly, the same as in \code{\link[base]{unlink}}.
#'
#' @export
wood_clear_cache <- function() {
  unlink(file.path(wood_tempdir(), "*"))
}

wood_tempdir <- function() {
  dir_path <- file.path(tempdir(), "woodendesc")
  if (!dir.exists(dir_path)) {
    dir.create(dir_path)
  }
  dir_path
}

cache_path <- function(...) {
  file.path(wood_tempdir(), paste0(paste("cache", ..., sep = "_"), ".rds"))
}
