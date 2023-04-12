.DEPENDENCY_TYPES <- c("Depends", "Imports", "LinkingTo", "Suggests", "Enhances")

extract_dependencies <- function(desc, parser = parse_dependencies) {
  deps <- lapply(
    .DEPENDENCY_TYPES,
    function(dep_type) {
      d <- desc[[dep_type]]
      if (!is.null(d) && !(length(d) == 1 && is.na(d)))
        cbind(parser(d),
              type = dep_type,
              stringsAsFactors = FALSE)
    }
  )
  if (any(lengths(deps)) > 0) {
    ret <- do.call(rbind, c(deps, stringsAsFactors = FALSE))
  } else {
    ret <- data.frame(
      package = character(),
      version = character(),
      type = character(),
      stringsAsFactors = FALSE
    )
  }
  as_wood_deps(ret)
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
