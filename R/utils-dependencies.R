#' Compress dependencies of multiple packages
#'
#' @description This function combines multiple dependency lists into a single
#' `data.frame` with additional info about "origin" package, i.e. which package
#' has this dependency.
#'
#' @param object \code{wood_dep_list}\cr
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

#' @export
filter_dependencies <- function(object, which = "strong") {
  UseMethod("filter_dependencies")
}

#' @rdname filter_dependencies
#' @export
filter_dependencies.wood_deps <- function(object, which = "strong") {
  dep_types <- match_dep_type(which)
  object[object[["type"]] %in% dep_types, ]
}

#' @rdname filter_dependencies
#' @export
filter_dependencies.wood_dep_list <- function(object, which = "strong") {
  as_wood_dep_list(lapply(object, filter_dependencies, which = which))
}

match_dep_type <- function(which) {
  dep_types <- c("Depends", "Imports", "LinkingTo", "Suggests", "Enhances")

  if (identical(which, "all")) return(dep_types)
  if (identical(which, "most")) return(dep_types[1:4])
  if (identical(which, "strong")) return(dep_types[1:3])

  # TODO: Make error messages more precise
  if (!all(which %in% dep_types))
    stop("Incorrect dependency type specified.", call. = FALSE)

  which
}
