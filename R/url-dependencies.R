
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
