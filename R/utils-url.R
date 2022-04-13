#' Get R-universe URL
#'
#' @description Creates an URL to the selected universe and the selected API
#' within this universe.
#'
#' @param universe \[\code{character(1)}\]\cr
#'  Name of a universe within R-universe, e.g. "ropensci".
#' @param ... \[\code{character(1)}\]\cr
#'  Components of the URL path, to be separated by slashes.
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
#' @param ... \[\code{character(1)}\]\cr
#'  Components of the URL path, to be separated by slashes.
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

#' Get Bioconductor URL
#'
#' @description Creates an URL to the selected Bioconductor API.
#'
#' @param ... \[\code{character(1)}\]\cr
#'  Components of the URL path, to be separated by slashes.
#'
#' @return A single string with an URL address to selected API.
#'
#' @noRd
bioc_url <- function(...) {
  paste("https://bioconductor.org", ..., sep = "/")
}
