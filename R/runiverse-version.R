#' @export
wood_runiverse_version <- function(package, universe = "ropensci") {
  runiverse_description_cache(package, universe)[["Version"]]
}

runiverse_description_cache <- function(package, universe = "ropensci") {
  cache_file <- cache_path("description", "runiverse", universe, package)

  if (is_cache_usable(cache_file)) return(readRDS(cache_file))

  url <- runiverse_url(universe, "packages", package, "any", "src")
  desc <- download_safely(url)

  if (length(desc) == 0) {
    stop(
      "received package data is empty; does this universe or package exist?",
      call. = FALSE
    )
  }

  # Save selected description fields
  desc <- desc[[1]][c("Version", "_hard_deps", "_soft_deps")]
  saveRDS(desc, cache_file)
  # Return saved object to save time on reading it
  desc
}
