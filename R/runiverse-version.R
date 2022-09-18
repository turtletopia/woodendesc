#' Get current package version in one of R universes
#'
#' @description This function queries the selected universe for the code of the
#' current version of the selected package.
#'
#' @template package
#' @template universe
#'
#' @return A single string with a version code.
#'
#' @examples
#' \donttest{
#' wood_runiverse_version("targets")
#' wood_runiverse_version("ggplot2", universe = "tidyverse")
#' }
#'
#' @family runiverse
#' @family versions
#' @export
wood_runiverse_version <- function(package, universe = "ropensci") {
  assert_param_package(package)
  assert_param_runiverse(universe)

  runiverse_description_cache(package, universe)[["version"]]
}

runiverse_description_cache <- function(package, universe = "ropensci") {
  with_cache({
    url <- runiverse_url(universe, "packages", package, "any", "src")
    desc <- download_safely(url)

    validate_runiverse_description(desc, package, universe)

    # Save selected description fields
    list(
      version = desc[[1]][["Version"]],
      deps = c(desc[[1]][["_hard_deps"]], desc[[1]][["_soft_deps"]])
    )
  }, "description", "runiverse", universe, package)
}
