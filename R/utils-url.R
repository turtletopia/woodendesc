#' Get R-universe URL
#'
#' @description Creates an URL to the selected universe and the selected API
#' within this universe.
#'
#' @param universe `character(1)`\cr
#'  Name of a universe within R-universe, e.g. "ropensci".
#' @param ... `character(1)`\cr
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
#' @param ... `character(1)`\cr
#'  Components of the URL path, to be separated by slashes.
#' @param params `list()`\cr
#'  Parameters to URL call in form of key:value named list.
#'
#' @return A single string with an URL address to specified METACRAN API.
#'
#' @importFrom utils URLencode
#' @noRd
crandb_url <- function(..., params = list()) {
  append_url_params(paste("http://crandb.r-pkg.org", ..., sep = "/"), params)
}

#' Get CRAN URL
#'
#' @description Creates an URL to the selected CRAN API.
#'
#' @param ... `character(1)`\cr
#'  Components of the URL path, to be separated by slashes.
#'
#' @return A single string with an URL address to selected API.
#'
#' @noRd
cran_url <- function(...) {
  paste("https://CRAN.R-project.org", ..., sep = "/")
}

raw_github_url <- function(...) {
  paste("https://raw.githubusercontent.com", ..., sep = "/")
}

github_url <- function(..., params = list()) {
  append_url_params(paste("https://api.github.com", ..., sep = "/"), params)
}

#' Get Bioconductor URL
#'
#' @description Creates an URL to the selected Bioconductor API.
#'
#' @param ... `character(1)`\cr
#'  Components of the URL path, to be separated by slashes.
#'
#' @return A single string with an URL address to selected API.
#'
#' @noRd
bioc_url <- function(...) {
  paste("https://bioconductor.org", ..., sep = "/")
}

#' @importFrom versionsort ver_latest
bioc_release_url <- function(release = "release", ...) {
  if (release %in% c("release", "devel")) {
    # Early return for special release names
    return(bioc_url("packages", release, "bioc", ...))
  }

  if (is_pkg_installed("xml2")) {
    # Perform precise check only if xml2 installed
    if (!release %in% wood_bioc_releases()) {
      stopf("Bioconductor release %1$s does not exist.", release)
    }
  }

  if (ver_latest(c(release, "1.8")) == release) {
    # Release at least 1.8
    bioc_url("packages", release, "bioc", ...)
  } else if (ver_latest(c(release, "1.5")) == release) {
    # Releases between 1.5 and 1.7 had different order of URL components
    bioc_url("packages", "bioc", release, ...)
  } else {
    stopf(
      c("`release` must be at least 1.5.\n",
        "(i) You've provided release code %1$s\n",
        "(i) Releases older than 1.5 are not supported"),
      release
    )
  }
}

append_url_params <- function(url, params) {
  # Add nothing if no parameters passed
  if (length(params) == 0) return(url)

  # Wrap strings into quotation marks
  params <- lapply(params, function(p) {
    if (is.character(p)) paste0("\"", p, "\"") else p
  })
  # Translate list of parameters into URL list
  params <- paste(names(params), params, sep = "=", collapse = "&")
  # Add question mark before listing parameters
  URLencode(paste(url, params, sep = "?"))
}

extract_core_url <- function(url) {
  sub("\\?.*", "", url)
}

remove_trailing_slash <- function(url) {
  gsub("/$", "", url)
}

add_trailing_slash <- function(url) {
  gsub("(?<=[^/])$", "/", url, perl = TRUE)
}
