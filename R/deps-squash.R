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
  deps <- deps[vapply(deps, nrow, numeric(1)) > 0]

  if (length(deps) == 0) {
    deps <- data.frame(
      origin = character(),
      package = character(),
      version = character(),
      type = character(),
      stringsAsFactors = FALSE
    )
  } else {
    # Add origin column
    deps <- mapply(
      cbind, origin = names(deps), deps, SIMPLIFY = FALSE, stringsAsFactors = FALSE
    )
    deps <- do.call(
      rbind, c(deps, make.row.names = FALSE, stringsAsFactors = FALSE)
    )
  }
  # Merge data frames
  as_wood_dep_squashed(deps)
}
