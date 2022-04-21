#' Get dependencies of locally available package
#'
#' @description This function extracts dependencies of the selected package,
#' searching through specified library paths.
#'
#' @template package
#' @template paths-local
#'
#' @return A data frame with three columns, all in string format:
#' * `package` (package name),
#' * `version` (minimum version requirement or `NA` if none),
#' * `type` (dependency type, e.g. `"Imports"`).
#'
#' @examples
#' \donttest{
#' wood_local_dependencies("woodendesc")
#' wood_local_dependencies("httr", paths = "all")
#' }
#'
#' @family local
#' @family dependencies
#' @export
wood_local_dependencies <- function(package, paths = .libPaths()[1]) {
  paths <- match_local_paths_args(paths)
  # Find first path for which DESCRIPTION exists
  desc_path <- Find(
    file.exists, file.path(paths, package, "DESCRIPTION")
  )
  # If none found, Find() returns NULL
  if (is.null(desc_path))
    stop("package not found in the specified paths", call. = FALSE)

  desc <- read_dcf(read_char(desc_path))[[package]]
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

parse_dependencies <- function(deps) {
  deps <- strsplit(deps, ",")[[1]]
  versions <- regmatches(deps, regexec(
    "\\(>=\\s+(.*)\\)", deps
  ))
  versions <- vapply(versions, `[`, character(1), 2)
  packages <- regmatches(deps, regexpr("\\S+", deps))
  data.frame(
    package = packages,
    version = versions,
    stringsAsFactors = FALSE
  )
}
