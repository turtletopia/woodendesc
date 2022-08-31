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

#' Filter dependencies by type
#'
#' @description This function removes all dependencies that are not one of the
#' specified types.
#'
#' @param object \code{wood_deps || wood_dep_list}\cr
#'  Dependencies to filter.
#' @param which \code{character()}\cr
#'  A vector listing the types of dependencies, a subset of
#'  \code{c("Depends", "Imports", "LinkingTo", "Suggests", "Enhances")}.
#'  Character string `"all"` is shorthand for that vector, character string
#'  `"most"`for the same vector without `"Enhances"`, character string
#'  `"strong"` (default) for the first three elements of that vector. The same
#'  convention as in \code{\link[tools]{package_dependencies}()}.
#'
#' @return Object of the same class as `object` parameter, but with filtered
#' dependencies.
#'
#' @examples
#' # It can filter both single-package dependencies...
#' stats_deps <- wood_core_dependencies("stats")
#' filter_dependencies(stats_deps)
#'
#' # ...and a list for multiple packages too.
#' core_pkgs <- wood_core_packages()
#' core_deps <- wood_dependencies(core_pkgs, "core")
#' filter_dependencies(core_deps, c("Imports", "Enhances"))
#'
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

#' @rdname filter_dependencies
#' @export
filter_dependencies.NULL <- function(object, which = "strong") { NULL }

match_dep_type <- function(which) {
  assert_param_which_deps(which)

  dep_types <- c("Depends", "Imports", "LinkingTo", "Suggests", "Enhances")

  if (identical(which, "all")) return(dep_types)
  if (identical(which, "most")) return(dep_types[1:4])
  if (identical(which, "strong")) return(dep_types[1:3])

  which
}
