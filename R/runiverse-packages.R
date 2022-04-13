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
  runiverse_packages_cache(universe)
}

runiverse_packages_cache <- function(universe = "ropensci") {
  cache_file <- cache_path("packages", "runiverse", universe)

  if (is_cache_usable(cache_file)) return(readRDS(cache_file))

  url <- runiverse_url(universe, "packages")
  packages <- download_safely(url)

  if (length(packages) == 0) {
    # Warn if response is empty
    warning(
      "received list of packages is empty; does this universe exist?",
      call. = FALSE
    )
    character()
  } else {
    # Save a non-empty vector of packages
    packages <- unlist(packages, recursive = FALSE)
    saveRDS(packages, cache_file)
    # Return saved object to save time on reading it
    packages
  }
}
