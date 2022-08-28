#' List available packages in one of R universes
#'
#' @description This function queries the selected universe for a list of
#' available packages. They are returned as a vector of strings, each element
#' being a package name.
#'
#' @template universe
#'
#' @return A character vector of available packages.
#'
#' @examples
#' \donttest{
#' wood_runiverse_packages()
#' wood_runiverse_packages("tidyverse")
#' }
#'
#' @family runiverse
#' @family packages
#' @export
wood_runiverse_packages <- function(universe = "ropensci") {
  assert_param_runiverse(universe)

  runiverse_packages_cache(universe)
}

runiverse_packages_cache <- function(universe = "ropensci") {
  with_cache({
    url <- runiverse_url(universe, "packages")
    packages <- download_safely(url)
    unlist(packages, recursive = FALSE)
  }, .if_null = {
    warning("received list of packages is empty; does this universe exist?", call. = FALSE)
    character()
  }, "packages", "runiverse", universe)
}
