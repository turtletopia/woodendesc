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

#' Get CRAN URL
#'
#' @description Creates an URL to the selected CRAN API with specified
#' parameters translated to an URL list. The list should be named. In case of
#' an empty list, parameters are simply not appended to the core URL.
#'
#' @template url-components
#' @param params \[\code{list}\]\cr
#'  Parameters to URL call in form of key:value named list.
#'
#' @return A single string with an URL address to specified CRAN API.
#'
#' @noRd
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
