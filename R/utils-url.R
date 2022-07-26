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

#' Get CRANDB URL
#'
#' @description Creates an URL to the selected METACRAN API with specified
#' parameters translated to an URL list. The list should be named. In case of
#' an empty list, parameters are simply not appended to the core URL.
#'
#' @param ... \[\code{character(1)}\]\cr
#'  Components of the URL path, to be separated by slashes.
#' @param params \[\code{list}\]\cr
#'  Parameters to URL call in form of key:value named list.
#'
#' @return A single string with an URL address to specified METACRAN API.
#'
#' @importFrom utils URLencode
#' @noRd
crandb_url <- function(..., params = list()) {
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
  URLencode(paste(ret, params, sep = "?"))
}

#' Get CRAN URL
#'
#' @description Creates an URL to the selected CRAN API.
#'
#' @param ... \[\code{character(1)}\]\cr
#'  Components of the URL path, to be separated by slashes.
#'
#' @return A single string with an URL address to selected API.
#'
#' @noRd
cran_url <- function(...) {
  paste("https://CRAN.R-project.org", ..., sep = "/")
}

github_url <- function(...) {
  paste("https://raw.githubusercontent.com", ..., sep = "/")
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

bioc_release_url <- function(release = "release", ...) {
  if (release %in% c("release", "devel")) {
    # Early return for special release names
    return(bioc_url("packages", release, "bioc", ...))
  }

  if (!release %in% wood_bioc_releases()) {
    stop("Release code does not exist.", call. = FALSE)
  }

  if (ver_latest(c(release, "1.8")) == release) {
    # Release at least 1.8
    paste("https://bioconductor.org", "packages", release, "bioc", ..., sep = "/")
  } else if (ver_latest(c(release, "1.5")) == release) {
    # Releases between 1.5 and 1.7 had different order of URL components
    paste("https://bioconductor.org", release, "packages", "bioc", ..., sep = "/")
  } else {
    stop("Unsupported release, cannot find PACKAGES file.", call. = FALSE)
  }
}

extract_core_url <- function(url) {
  sub("\\?.*", "", url)
}

remove_trailing_slash <- function(url) {
  gsub("/$", "", url)
}
