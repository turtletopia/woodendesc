extract_dependencies <- function(desc, parser = parse_dependencies) {
  deps <- lapply(
    c("Depends", "Imports", "Suggests", "LinkingTo", "Enhances"),
    function(dep_type) {
      d <- desc[[dep_type]]
      if (!is.null(d) && !(length(d) == 1 && is.na(d)))
        cbind(parser(d),
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
