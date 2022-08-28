#' Get dependencies of a package in one of R universes
#'
#' @description This function queries the selected universe for dependencies
#' of the selected package.
#'
#' @template package
#' @template universe
#'
#' @return A data frame with three columns, all in string format:
#' * `package` (package name),
#' * `version` (minimum version requirement or `NA` if none),
#' * `type` (dependency type, e.g. `"Imports"`).
#'
#' @examples
#' \donttest{
#' wood_runiverse_dependencies("targets")
#' wood_runiverse_dependencies("ggplot2", universe = "tidyverse")
#' }
#'
#' @family runiverse
#' @family dependencies
#' @export
wood_runiverse_dependencies <- function(package, universe = "ropensci") {
  assert_param_package(package)
  assert_param_runiverse(universe)

  desc <- runiverse_description_cache(package, universe)
  ret <- data.frame(
    package = vapply(desc[["deps"]], `[[`, character(1), "package"),
    version = vapply(desc[["deps"]], function(dep) {
      version <- dep[["version"]]
      if (is.null(version)) return(NA_character_)
      version <- regmatches(version, regexec(
        ">=\\s+(.*)", version
      ))[[1]][2]
    }, character(1)),
    type = vapply(desc[["deps"]], `[[`, character(1), "role"),
    stringsAsFactors = FALSE
  )
  as_wood_deps(ret)
}
