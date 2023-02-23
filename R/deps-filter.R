#' Filter dependencies by type
#'
#' @description This function removes all dependencies that are not one of the
#' specified types.
#'
#' @param object `wood_deps() || wood_dep_list()`\cr
#'  Dependencies to filter.
#' @param which `character()`\cr
#'  A vector listing the types of dependencies, a subset of
#'  `c("Depends", "Imports", "LinkingTo", "Suggests", "Enhances")`.
#'  Character string `"all"` is shorthand for that vector, character string
#'  `"most"`for the same vector without `"Enhances"`, character string
#'  `"strong"` (default) for the first three elements of that vector. The same
#'  convention as in [tools::package_dependencies()].
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
filter_dependencies.wood_dep_squashed <- function(object, which = "strong") {
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

  if (identical(which, "all")) return(.DEPENDENCY_TYPES)
  if (identical(which, "most")) return(.DEPENDENCY_TYPES[1:4])
  if (identical(which, "strong")) return(.DEPENDENCY_TYPES[1:3])

  which
}
