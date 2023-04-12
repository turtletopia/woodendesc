as_wood_deps <- function(df) {
  # Colnames should be "package", "version", and "type", in this order
  if (!identical(colnames(df), c("package", "version", "type")))
    stop("Unexpected set of columns in dependency list.", call. = FALSE)

  structure(
    df,
    class = c("wood_deps", class(df))
  )
}

# nocov start
#' @export
print.wood_deps <- function(x, ..., package = NULL) {
  # Header
  if (is.null(package)) {
    cat("<dependencies>\n")
  } else {
    cat(sprintf(" <%s dependencies>\n", package))
  }

  # Body
  for (i in seq_len(nrow(x))) {
    cat(sprintf(
      "  %1$-12s %2$s",
      paste0(x[[i, "type"]], ":"),
      x[[i, "package"]]
    ))
    if (!is.na(x[[i, "version"]])) {
      cat(sprintf(" (>= %s)", x[[i, "version"]]))
    }
    cat("\n")
  }
}

#' @export
summary.wood_deps <- function(object, ...) {
  structure(
    data.frame(
      type = .DEPENDENCY_TYPES,
      count = vapply(.DEPENDENCY_TYPES, function(dep_type) {
        sum(object[["type"]] == dep_type)
      }, integer(1), USE.NAMES = FALSE)
    ),
    class = c("wood_deps_summary", "data.frame")
  )
}

#' @export
print.wood_deps_summary <- function(x, ...) {
  # Header
  cat("<summary of dependencies>\n")

  # Body
  max_count_length <- max(nchar(x[["count"]]))
  for (i in seq_len(nrow(x))) {
    if (x[[i, "count"]] > 0) {
      # Create sprintf pattern based on max count length
      pattern <- paste0(" - %1$", max_count_length, "i %2$s\n")
      # ...and use this pattern
      cat(sprintf(pattern, x[[i, "count"]], x[[i, "type"]]))
    }
  }
}
# nocov end
