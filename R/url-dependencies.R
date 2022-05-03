#' Get dependencies of a package in any repository
#'
#' @description This function queries any online repository for dependencies of
#' the selected package.
#'
#' @template package
#' @template repository
#'
#' @return A data frame with three columns, all in string format:
#' * `package` (package name),
#' * `version` (minimum version requirement or `NA` if none),
#' * `type` (dependency type, e.g. `"Imports"`).
#'
#' @examples
#' \donttest{
#' wood_url_dependencies("XML", repository = "http://www.omegahat.net/R")
#' }
#'
#' @family url
#' @family dependencies
#' @export
wood_url_dependencies <- function(package, repository) {
  desc <- url_PACKAGES_cache(repository)[[package]]

  if (is.null(desc))
    stop("package not found in the specified URL", call. = FALSE)

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
