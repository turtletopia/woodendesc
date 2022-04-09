#' @export
wood_runiverse_packages <- function(universe = "ropensci") {
  runiverse_packages_cache(universe)
}

#' @importFrom httr GET content stop_for_status
runiverse_packages_cache <- function(universe = "ropensci") {
  cache_file <- cache_path("packages", "runiverse", universe)

  if (!is_cache_usable(cache_file)) {
    url <- paste0("https://", universe, ".r-universe.dev/packages")
    response <- GET(url)
    # Raise an exception when status code is 400 or higher
    stop_for_status(response, task = paste0("download data from ", url))
    # Else proceed to save a vector of packages
    packages <- unlist(content(response))
    saveRDS(packages, cache_file)
    # Return saved object to save time on reading it
    packages
  } else {
    readRDS(cache_file)
  }
}
