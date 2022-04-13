#' Get R-universe URL
#'
#' @description Creates an URL to the selected universe and the selected API
#' within this universe.
#'
#' @template universe
#' @template url-components
#'
#' @return A single string with an URL address to selected universe.
#'
#' @noRd
runiverse_url <- function(universe, ...) {
  paste(paste0("https://", universe, ".r-universe.dev"), ..., sep = "/")
}
