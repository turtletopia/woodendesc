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

cran_url <- function(..., params = list()) {
  ret <- paste("http://crandb.r-pkg.org", ..., sep = "/")

  # Add nothing if no parameters passed
  if (length(params) == 0) return(ret)

  # Wrap strings into quotation marks
  params <- lapply(params, function(p) {
    if (is.character(p)) paste0("\"", p, "\"") else p
  })
  # Translate list of parameters into URL list
  params <- paste(names(params), params, sep = "=", collapse = "&")
  # Add question mark before listing parameters
  paste(ret, params, sep = "?")
}
