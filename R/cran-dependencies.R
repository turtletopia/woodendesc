#' Get dependencies of a package on CRAN
#'
#' @description This function queries CRAN for dependencies of the selected
#' version of a selected package. By default, it queries the latest version.
#'
#' @template package
#' @param version \[\code{character(1)}\]\cr
#'  A version code without leading `"v"`, e.g. `"1.6.0"`.
#'
#' @return A data frame with three columns, all in string format:
#' * `package` (package name),
#' * `version` (minimum version requirement or `NA` if none),
#' * `type` (dependency type, e.g. `"Imports"`).
#'
#' @examples
#' \donttest{
#' wood_cran_dependencies("ggplot2")
#' wood_cran_dependencies("deepdep", version = "0.2.1")
#' }
#'
#' @family cran
#' @family dependencies
#' @export
wood_cran_dependencies <- function(package, version = "latest") {
  version <- match_version_cran(package, version)

  descs <- cran_descriptions_cache(package)
  # Use cached data if available
  if (!is.null(descs)) {
    desc <- descs[[version]]
    if (!is.null(desc)) {
      deps <- lapply(
        c("Depends", "Imports", "Suggests", "LinkingTo", "Enhances"),
        function(dep_type) {
          if (!is.null(desc[[dep_type]]))
            cbind(parse_dependencies_crandb(desc[[dep_type]]),
                  type = dep_type,
                  stringsAsFactors = FALSE)
        }
      )
      deps <- do.call(rbind, c(deps, stringsAsFactors = FALSE))
      return(deps)
    }
  }
  # If not, try version-specific cache
  desc <- cran_dependencies_cache(package, version)
  deps <- lapply(
    c("Depends", "Imports", "Suggests", "LinkingTo", "Enhances"),
    function(dep_type) {
      if (!is.null(desc[[dep_type]]))
        cbind(parse_dependencies(desc[[dep_type]]),
              type = dep_type,
              stringsAsFactors = FALSE)
    }
  )
  do.call(rbind, c(deps, stringsAsFactors = FALSE))
}

cran_descriptions_cache <- function(package) {
  cache_file <- cache_path("descriptions", "CRAN", package)

  # Return usable cache if exists
  if (is_cache_usable(cache_file)) readRDS(cache_file) else NULL
}

cran_dependencies_cache <- function(package, version) {
  cache_file <- cache_path("dependencies", "CRAN", package, version)

  if (is_cache_usable(cache_file)) return(readRDS(cache_file))

  url <- github_url("cran", package, version, "DESCRIPTION")
  desc <- download_safely(url)
  desc <- read_dcf(desc)[[package]]

  saveRDS(desc, cache_file)
  desc
}

match_version_cran <- function(package, version) {
  if (version == "latest") wood_cran_latest(package) else version
}

parse_dependencies_crandb <- function(deps) {
  versions <- regmatches(deps, regexec(
    ">=\\s+(.*)", deps
  ))
  versions <- vapply(versions, `[`, character(1), 2, USE.NAMES = FALSE)
  packages <- names(deps)
  data.frame(
    package = packages,
    version = versions,
    stringsAsFactors = FALSE
  )
}
