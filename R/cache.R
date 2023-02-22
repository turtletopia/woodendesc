#' Clear cache
#'
#' @description Remove all \pkg{woodendesc}-related cached files.
#'
#' @return An integer code, invisibly, the same as in [base::unlink()].
#'
#' @export
wood_clear_cache <- function() {
  unlink(file.path(wood_tempdir(), "cache*"))
}

#' Wrap expression with cache
#'
#' @description Adds caching to an expression with a specified cache file.
#'
#' @param expr `call(1)`\cr
#'  An expression in brackets to evaluate if cache not usable.
#' @param ... `character(1)`\cr
#'  Components of the path filename.
#' @param .if_null `call(1)`\cr
#'  An expression to execute if value is `NULL`, returns `NULL` by default.
#'
#' @return A value returned by `expr` or a cache (if valid).
#'
#' @noRd
with_cache <- function(expr, ..., .if_null = {}) {
  cache_file <- cache_path(...)
  if (is_cache_usable(cache_file)) return(readRDS(cache_file))

  ret <- evalq(expr)

  if (is.null(ret)) {
    evalq(.if_null)
  } else {
    saveRDS(ret, cache_file)
    # Return saved object to save time on reading it
    ret
  }
}

#' Create and access woodendesc temporary directory
#'
#' @description Returns the path to woodendesc temporary directory. If the
#' directory doesn't exist, creates it.
#'
#' @return A string with the path to woodendesc temporary directory.
#'
#' @noRd
wood_tempdir <- function() {
  dir_path <- file.path(tempdir(), "woodendesc")
  if (!dir.exists(dir_path)) {
    dir.create(dir_path)
  }
  dir_path
}

#' Create path for cache file
#'
#' @description Creates a cache filename from specified components. These
#' components are separated by underscores and should allow for easy recognizing
#' what cache is stored inside.
#'
#' @param ... `character(1)`\cr
#'  Components of the filename, to be separated by underscores.
#'
#' @return A string with a path to woodendesc cache file.
#'
#' @noRd
cache_path <- function(...) {
  file.path(wood_tempdir(), paste0(paste("cache", ..., sep = "_"), ".rds"))
}

#' Check cache usability
#'
#' @description Checks if the cache exists and if it is older than the limit.
#' The limit can be modified with `wood_cache_time` option.
#'
#' @param file `character(1)`\cr
#'  Path to file that is to be verified.
#'
#' @return A boolean indicating if the cache is usable.
#'
#' @noRd
is_cache_usable <- function(file) {
  file.exists(file) &&
    difftime(Sys.time(), file.info(file)[["mtime"]], units = "secs") <
    getOption("wood_cache_time", default = 60 * 60 * 3)
}
