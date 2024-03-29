% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/deps-filter.R
\name{filter_dependencies}
\alias{filter_dependencies}
\alias{filter_dependencies.wood_deps}
\alias{filter_dependencies.wood_dep_squashed}
\alias{filter_dependencies.wood_dep_list}
\alias{filter_dependencies.NULL}
\title{Filter dependencies by type}
\usage{
filter_dependencies(object, which = "strong")

\method{filter_dependencies}{wood_deps}(object, which = "strong")

\method{filter_dependencies}{wood_dep_squashed}(object, which = "strong")

\method{filter_dependencies}{wood_dep_list}(object, which = "strong")

\method{filter_dependencies}{`NULL`}(object, which = "strong")
}
\arguments{
\item{object}{\code{wood_deps() || wood_dep_list()}\cr
Dependencies to filter.}

\item{which}{\code{character()}\cr
A vector listing the types of dependencies, a subset of
\code{c("Depends", "Imports", "LinkingTo", "Suggests", "Enhances")}.
Character string \code{"all"} is shorthand for that vector, character string
\code{"most"}for the same vector without \code{"Enhances"}, character string
\code{"strong"} (default) for the first three elements of that vector. The same
convention as in \code{\link[tools:package_dependencies]{tools::package_dependencies()}}.}
}
\value{
Object of the same class as \code{object} parameter, but with filtered
dependencies.
}
\description{
This function removes all dependencies that are not one of the
specified types.
}
\examples{
# It can filter both single-package dependencies...
stats_deps <- wood_core_dependencies("stats")
filter_dependencies(stats_deps)

# ...and a list for multiple packages too.
core_pkgs <- wood_core_packages()
core_deps <- wood_dependencies(core_pkgs, "core")
filter_dependencies(core_deps, c("Imports", "Enhances"))

}
