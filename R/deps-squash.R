#' Compress dependencies of multiple packages
#'
#' @description This function combines multiple dependency lists into a single
#' `data.frame` with additional info about "origin" package, i.e. which package
#' has this dependency.
#'
#' @param object `wood_dep_list()`\cr
#'  A list of dependencies to compress.
#'
#' @return A `data.frame` object similar to these returned by `_dependencies`
#' functions, but with additional column named `origin`.
#'
#' @examples
#' \donttest{
#' deps <- wood_dependencies(c("versionsort", "deepdep", "gglgbtq"))
#' squash(deps)
#' }
#'
#' @export
squash <- function(object) {
  UseMethod("squash")
}

#' @rdname squash
#' @export
squash.wood_dep_list <- function(object) {
  # Filter out empty and NULL dependencies
  deps <- object[!vapply(object, is.null, logical(1))]
  deps <- deps[lengths(deps) > 0]
  # Add origin column
  deps <- mapply(cbind, origin = names(deps), deps, SIMPLIFY = FALSE)
  # Merge data frames
  do.call(rbind, c(deps, make.row.names = FALSE))
}