#' @export
wood_runiverse_dependencies <- function(package, universe = "ropensci") {
  desc <- runiverse_description_cache(package, universe)
  data.frame(
    package = vapply(desc[["deps"]], `[[`, character(1), "package"),
    version = vapply(desc[["deps"]], function(dep) {
      version <- dep[["version"]]
      if (is.null(version)) NA_character_ else version
    }, character(1)),
    type = vapply(desc[["deps"]], `[[`, character(1), "role")
  )
}
